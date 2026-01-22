import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SharedPreferences & SecureStorage wrapper service
/// Provides type-safe methods for storing and retrieving data
class StorageService {
  static StorageService? _instance;
  static SharedPreferences? _preferences;
  static FlutterSecureStorage? _secureStorage;

  StorageService._();

  static Future<StorageService> getInstance() async {
    _instance ??= StorageService._();
    _preferences ??= await SharedPreferences.getInstance();
    _secureStorage ??= const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );
    return _instance!;
  }

  // --- Secure Storage Operations ---

  /// Set a secure string value
  Future<void> setSecureString(String key, String value) async {
    await _secureStorage!.write(key: key, value: value);
  }

  /// Get a secure string value
  Future<String?> getSecureString(String key) async {
    return await _secureStorage!.read(key: key);
  }

  /// Delete a secure value
  Future<void> deleteSecure(String key) async {
    await _secureStorage!.delete(key: key);
  }

  /// Clear all secure values
  Future<void> clearSecure() async {
    await _secureStorage!.deleteAll();
  }

  // --- SharedPreferences Operations ---

  // String operations
  Future<bool> setString(String key, String value) async {
    return await _preferences!.setString(key, value);
  }

  String? getString(String key, {String? defaultValue}) {
    return _preferences!.getString(key) ?? defaultValue;
  }

  // Int operations
  Future<bool> setInt(String key, int value) async {
    return await _preferences!.setInt(key, value);
  }

  int? getInt(String key, {int? defaultValue}) {
    return _preferences!.getInt(key) ?? defaultValue;
  }

  // Double operations
  Future<bool> setDouble(String key, double value) async {
    return await _preferences!.setDouble(key, value);
  }

  double? getDouble(String key, {double? defaultValue}) {
    return _preferences!.getDouble(key) ?? defaultValue;
  }

  // Bool operations
  Future<bool> setBool(String key, bool value) async {
    return await _preferences!.setBool(key, value);
  }

  bool? getBool(String key, {bool? defaultValue}) {
    return _preferences!.getBool(key) ?? defaultValue;
  }

  // List<String> operations
  Future<bool> setStringList(String key, List<String> value) async {
    return await _preferences!.setStringList(key, value);
  }

  List<String>? getStringList(String key, {List<String>? defaultValue}) {
    return _preferences!.getStringList(key) ?? defaultValue;
  }

  // JSON operations
  Future<bool> setJson(String key, Map<String, dynamic> value) async {
    return await setString(key, jsonEncode(value));
  }

  Map<String, dynamic>? getJson(String key) {
    final jsonString = getString(key);
    if (jsonString == null) return null;

    try {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  // List<Map> operations (for caching arrays of objects)
  Future<bool> setJsonList(String key, List<Map<String, dynamic>> value) async {
    return await setString(key, jsonEncode(value));
  }

  List<Map<String, dynamic>>? getJsonList(String key) {
    final jsonString = getString(key);
    if (jsonString == null) return null;

    try {
      final decoded = jsonDecode(jsonString) as List;
      return decoded.map((e) => e as Map<String, dynamic>).toList();
    } catch (e) {
      return null;
    }
  }

  // Remove operations
  Future<bool> remove(String key) async {
    return await _preferences!.remove(key);
  }

  // Clear all
  Future<bool> clear() async {
    return await _preferences!.clear();
  }

  // Check if key exists
  bool containsKey(String key) {
    return _preferences!.containsKey(key);
  }

  // Get all keys
  Set<String> getKeys() {
    return _preferences!.getKeys();
  }

  // Timestamp operations (for cache expiry)
  Future<bool> setTimestamp(String key) async {
    return await setInt(key, DateTime.now().millisecondsSinceEpoch);
  }

  DateTime? getTimestamp(String key) {
    final timestamp = getInt(key);
    if (timestamp == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  // Check if cache is expired
  bool isCacheExpired(String key, {int maxAgeInMinutes = 5}) {
    final timestamp = getTimestamp(key);
    if (timestamp == null) return true;

    final now = DateTime.now();
    final age = now.difference(timestamp).inMinutes;
    return age >= maxAgeInMinutes;
  }
}
