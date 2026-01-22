import 'storage_service.dart';
import 'storage_keys.dart';
import 'package:flutter/material.dart';

/// User preferences manager
/// Handles user settings and preferences
class UserPreferences {
  final StorageService _storage;

  UserPreferences(this._storage);

  // Theme
  Future<bool> setThemeMode(ThemeMode mode) async {
    return await _storage.setString(
      StorageKeys.themeMode,
      mode.toString().split('.').last,
    );
  }

  ThemeMode getThemeMode() {
    final modeString = _storage.getString(
      StorageKeys.themeMode,
      defaultValue: 'system',
    );
    
    switch (modeString) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  // Language
  Future<bool> setLanguage(String languageCode) async {
    return await _storage.setString(StorageKeys.language, languageCode);
  }

  String getLanguage() {
    return _storage.getString(StorageKeys.language, defaultValue: 'tr')!;
  }

  Locale getLocale() {
    final languageCode = getLanguage();
    return Locale(languageCode);
  }

  // Notifications
  Future<bool> setNotificationsEnabled(bool enabled) async {
    return await _storage.setBool(StorageKeys.notificationsEnabled, enabled);
  }

  bool getNotificationsEnabled() {
    return _storage.getBool(
      StorageKeys.notificationsEnabled,
      defaultValue: true,
    )!;
  }

  Future<bool> setEmailNotifications(bool enabled) async {
    return await _storage.setBool(StorageKeys.emailNotifications, enabled);
  }

  bool getEmailNotifications() {
    return _storage.getBool(
      StorageKeys.emailNotifications,
      defaultValue: true,
    )!;
  }

  Future<bool> setPushNotifications(bool enabled) async {
    return await _storage.setBool(StorageKeys.pushNotifications, enabled);
  }

  bool getPushNotifications() {
    return _storage.getBool(
      StorageKeys.pushNotifications,
      defaultValue: true,
    )!;
  }

  // Reminder time (minutes before appointment)
  Future<bool> setReminderTime(int minutes) async {
    return await _storage.setInt(StorageKeys.reminderTime, minutes);
  }

  int getReminderTime() {
    return _storage.getInt(
      StorageKeys.reminderTime,
      defaultValue: 60, // 1 hour default
    )!;
  }

  // Onboarding
  Future<bool> setOnboardingCompleted(bool completed) async {
    return await _storage.setBool(StorageKeys.hasCompletedOnboarding, completed);
  }

  bool hasCompletedOnboarding() {
    return _storage.getBool(
      StorageKeys.hasCompletedOnboarding,
      defaultValue: false,
    )!;
  }

  Future<bool> setFirstLaunch(bool isFirst) async {
    return await _storage.setBool(StorageKeys.firstLaunch, isFirst);
  }

  bool isFirstLaunch() {
    return _storage.getBool(
      StorageKeys.firstLaunch,
      defaultValue: true,
    )!;
  }

  // Search history
  Future<bool> addSearchQuery(String query) async {
    final searches = getSearchHistory();
    
    // Remove if already exists
    searches.remove(query);
    
    // Add to beginning
    searches.insert(0, query);
    
    // Limit to max history
    if (searches.length > StorageKeys.maxSearchHistory) {
      searches.removeRange(
        StorageKeys.maxSearchHistory,
        searches.length,
      );
    }
    
    return await _storage.setStringList(StorageKeys.recentSearches, searches);
  }

  List<String> getSearchHistory() {
    return _storage.getStringList(
      StorageKeys.recentSearches,
      defaultValue: [],
    )!;
  }

  Future<bool> clearSearchHistory() async {
    return await _storage.remove(StorageKeys.recentSearches);
  }

  // Favorites
  Future<bool> addFavoriteBusiness(String businessId) async {
    final favorites = getFavoriteBusinesses();
    
    if (!favorites.contains(businessId)) {
      favorites.add(businessId);
      return await _storage.setStringList(
        StorageKeys.favoriteBusinesses,
        favorites,
      );
    }
    
    return true;
  }

  Future<bool> removeFavoriteBusiness(String businessId) async {
    final favorites = getFavoriteBusinesses();
    favorites.remove(businessId);
    return await _storage.setStringList(
      StorageKeys.favoriteBusinesses,
      favorites,
    );
  }

  bool isFavoriteBusiness(String businessId) {
    final favorites = getFavoriteBusinesses();
    return favorites.contains(businessId);
  }

  List<String> getFavoriteBusinesses() {
    return _storage.getStringList(
      StorageKeys.favoriteBusinesses,
      defaultValue: [],
    )!;
  }

  Future<bool> clearFavorites() async {
    return await _storage.remove(StorageKeys.favoriteBusinesses);
  }

  // Last selected
  Future<bool> setLastSelectedCategory(String category) async {
    return await _storage.setString(StorageKeys.lastSelectedCategory, category);
  }

  String? getLastSelectedCategory() {
    return _storage.getString(StorageKeys.lastSelectedCategory);
  }

  Future<bool> setLastSelectedBusinessId(String businessId) async {
    return await _storage.setString(
      StorageKeys.lastSelectedBusinessId,
      businessId,
    );
  }

  String? getLastSelectedBusinessId() {
    return _storage.getString(StorageKeys.lastSelectedBusinessId);
  }

  // App state
  Future<bool> setLastAppVersion(String version) async {
    return await _storage.setString(StorageKeys.lastAppVersion, version);
  }

  String? getLastAppVersion() {
    return _storage.getString(StorageKeys.lastAppVersion);
  }

  Future<bool> setLastUpdateCheck() async {
    return await _storage.setTimestamp(StorageKeys.lastUpdateCheck);
  }

  DateTime? getLastUpdateCheck() {
    return _storage.getTimestamp(StorageKeys.lastUpdateCheck);
  }

  // Clear all preferences (logout)
  Future<bool> clearAllPreferences() async {
    // Keep onboarding status
    final hasOnboarded = hasCompletedOnboarding();
    
    await _storage.clear();
    
    // Restore onboarding status
    if (hasOnboarded) {
      await setOnboardingCompleted(true);
    }
    
    return true;
  }
}
