import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../core/services/qr_service.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/appointment_model.dart';
import 'package:intl/intl.dart';

/// QR Code Screen
/// Displays QR code for appointment check-in
class QrCodeScreen extends ConsumerWidget {
  final AppointmentModel appointment;

  const QrCodeScreen({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Generate QR data
    final qrData = QrService.generateQrData(
      appointmentId: appointment.id,
      businessId: appointment.businessId,
      customerId: appointment.customerId,
    );

    final canCheckIn = QrService.canCheckIn(appointment.dateTime);
    final checkInMessage = QrService.getCheckInMessage(appointment.dateTime);

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Randevu QR Kod',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            onPressed: () => _showInfoDialog(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Appointment Info Card
            _buildAppointmentInfo(context),
            
            const SizedBox(height: 32),
            
            // QR Code Container
            _buildQrCode(context, qrData, canCheckIn),
            
            const SizedBox(height: 24),
            
            // Check-in Status
            _buildCheckInStatus(context, canCheckIn, checkInMessage),
            
            const SizedBox(height: 32),
            
            // Instructions
            _buildInstructions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentInfo(BuildContext context) {
    final dateFormat = DateFormat('d MMMM yyyy, EEEE', 'tr_TR');
    final timeFormat = DateFormat('HH:mm');

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.business,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.businessName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      appointment.serviceNames.join(', '),
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.grey, height: 1),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem(
                  icon: Icons.calendar_today,
                  label: 'Tarih',
                  value: dateFormat.format(appointment.dateTime),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildInfoItem(
                  icon: Icons.access_time,
                  label: 'Saat',
                  value: timeFormat.format(appointment.dateTime),
                ),
              ),
              Expanded(
                child: _buildInfoItem(
                  icon: Icons.timer_outlined,
                  label: 'Süre',
                  value: '${appointment.duration} dk',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 18),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQrCode(BuildContext context, String qrData, bool canCheckIn) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: canCheckIn
                ? AppColors.primary.withValues(alpha: 0.3)
                : Colors.grey.withValues(alpha: 0.2),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          if (!canCheckIn)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Henüz aktif değil',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          if (!canCheckIn) const SizedBox(height: 16),
          
          // QR Code
          Opacity(
            opacity: canCheckIn ? 1.0 : 0.3,
            child: QrImageView(
              data: qrData,
              version: QrVersions.auto,
              size: 280,
              backgroundColor: Colors.white,
              errorCorrectionLevel: QrErrorCorrectLevel.H,
              embeddedImage: canCheckIn
                  ? null
                  : const AssetImage('assets/icons/lock.png'),
              embeddedImageStyle: const QrEmbeddedImageStyle(
                size: Size(40, 40),
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          Text(
            'Randevu #${appointment.id}',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckInStatus(
    BuildContext context,
    bool canCheckIn,
    String message,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: canCheckIn
            ? AppColors.primary.withValues(alpha: 0.2)
            : Colors.orange.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: canCheckIn
              ? AppColors.primary.withValues(alpha: 0.5)
              : Colors.orange.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            canCheckIn ? Icons.check_circle : Icons.schedule,
            color: canCheckIn ? AppColors.primary : Colors.orange,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  canCheckIn ? 'Check-in Hazır' : 'Check-in Bekleniyor',
                  style: TextStyle(
                    color: canCheckIn ? AppColors.primary : Colors.orange,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  message,
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nasıl Kullanılır?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildInstructionItem(
          number: '1',
          text: 'Randevu saatinizden 30 dakika önce QR kod aktif olur',
        ),
        const SizedBox(height: 12),
        _buildInstructionItem(
          number: '2',
          text: 'İşletmeye geldiğinizde QR kodu görevliye gösterin',
        ),
        const SizedBox(height: 12),
        _buildInstructionItem(
          number: '3',
          text: 'Görevli QR kodu okutarak check-in işleminizi tamamlar',
        ),
        const SizedBox(height: 12),
        _buildInstructionItem(
          number: '4',
          text: 'QR kod 24 saat geçerlidir',
        ),
      ],
    );
  }

  Widget _buildInstructionItem({
    required String number,
    required String text,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.2),
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primary,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'QR Kod Hakkında',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bu QR kod randevunuz için özel olarak oluşturulmuştur.',
              style: TextStyle(color: Colors.grey[300]),
            ),
            const SizedBox(height: 12),
            Text(
              '• Güvenlik: Şifreli ve imzalı\n'
              '• Geçerlilik: 24 saat\n'
              '• Check-in penceresi: 30 dk önce - 15 dk sonra\n'
              '• Kullanım: Tek seferlik',
              style: TextStyle(color: Colors.grey[400], fontSize: 13),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Tamam',
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
