import 'dart:convert';
import 'package:crypto/crypto.dart';

/// QR Code Service
/// Handles QR code generation and validation for appointments
class QrService {
  /// Generate QR data for an appointment
  /// 
  /// Returns a JSON string containing:
  /// - appointmentId: The appointment ID
  /// - businessId: The business ID
  /// - timestamp: Current timestamp for time-based validation
  /// - signature: HMAC signature for security
  static String generateQrData({
    required String appointmentId,
    required String businessId,
    required String customerId,
  }) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    
    // Create data object
    final data = {
      'appointmentId': appointmentId,
      'businessId': businessId,
      'customerId': customerId,
      'timestamp': timestamp,
      'version': '1.0',
    };
    
    // Generate signature for security
    final signature = _generateSignature(data);
    data['signature'] = signature;
    
    // Return JSON string
    return jsonEncode(data);
  }
  
  /// Validate QR code data
  /// 
  /// Returns true if:
  /// - Signature is valid
  /// - QR code is not expired (within 24 hours)
  /// - All required fields are present
  static Map<String, dynamic>? validateQrData(String qrData) {
    try {
      final data = jsonDecode(qrData) as Map<String, dynamic>;
      
      // Check required fields
      if (!data.containsKey('appointmentId') ||
          !data.containsKey('businessId') ||
          !data.containsKey('customerId') ||
          !data.containsKey('timestamp') ||
          !data.containsKey('signature')) {
        return null;
      }
      
      // Verify signature
      final providedSignature = data['signature'] as String;
      final dataWithoutSignature = Map<String, dynamic>.from(data)
        ..remove('signature');
      final expectedSignature = _generateSignature(dataWithoutSignature);
      
      if (providedSignature != expectedSignature) {
        return null; // Invalid signature
      }
      
      // Check expiration (24 hours)
      final timestamp = data['timestamp'] as int;
      final qrTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      final now = DateTime.now();
      final difference = now.difference(qrTime);
      
      if (difference.inHours > 24) {
        return null; // Expired
      }
      
      return data;
    } catch (e) {
      return null; // Invalid format
    }
  }
  
  /// Generate HMAC signature for security
  /// 
  /// In production, use a proper secret key from environment variables
  static String _generateSignature(Map<String, dynamic> data) {
    const secretKey = 'timesync_secret_key_2025'; // TODO: Move to env variables
    final dataString = _sortedJsonString(data);
    final key = utf8.encode(secretKey);
    final bytes = utf8.encode(dataString);
    final hmac = Hmac(sha256, key);
    final digest = hmac.convert(bytes);
    return digest.toString();
  }
  
  /// Convert map to sorted JSON string for consistent hashing
  static String _sortedJsonString(Map<String, dynamic> data) {
    final sortedKeys = data.keys.toList()..sort();
    final sortedMap = <String, dynamic>{};
    for (final key in sortedKeys) {
      sortedMap[key] = data[key];
    }
    return jsonEncode(sortedMap);
  }
  
  /// Check if appointment is eligible for check-in
  /// 
  /// Returns true if:
  /// - Appointment is within 30 minutes before start time
  /// - Appointment is not more than 15 minutes after start time
  static bool canCheckIn(DateTime appointmentTime) {
    final now = DateTime.now();
    final difference = appointmentTime.difference(now);
    
    // Can check in 30 minutes before
    if (difference.inMinutes > 30) {
      return false;
    }
    
    // Can still check in 15 minutes after start time
    if (difference.inMinutes < -15) {
      return false;
    }
    
    return true;
  }
  
  /// Get check-in time window message
  static String getCheckInMessage(DateTime appointmentTime) {
    final now = DateTime.now();
    final difference = appointmentTime.difference(now);
    
    if (difference.inMinutes > 30) {
      final hours = difference.inHours;
      final minutes = difference.inMinutes % 60;
      if (hours > 0) {
        return 'Check-in ${hours} saat $minutes dakika sonra açılacak';
      }
      return 'Check-in ${difference.inMinutes} dakika sonra açılacak';
    }
    
    if (difference.inMinutes < -15) {
      return 'Check-in süresi doldu';
    }
    
    if (difference.inMinutes < 0) {
      return 'Randevu başladı - Hemen check-in yapın!';
    }
    
    return 'Check-in için hazır';
  }
}
