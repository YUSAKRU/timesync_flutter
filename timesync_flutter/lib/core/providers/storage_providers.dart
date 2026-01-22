import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../storage/storage_service.dart';
import '../storage/user_preferences.dart';
import '../storage/cache_manager.dart';

/// Storage providers
/// Singleton instances for storage services

// Storage service provider
final storageServiceProvider = FutureProvider<StorageService>((ref) async {
  return await StorageService.getInstance();
});

// User preferences provider
final userPreferencesProvider = Provider<UserPreferences>((ref) {
  final storage = ref.watch(storageServiceProvider).asData?.value;
  if (storage == null) {
    throw Exception('StorageService not initialized');
  }
  return UserPreferences(storage);
});

// Cache manager provider
final cacheManagerProvider = Provider<CacheManager>((ref) {
  final storage = ref.watch(storageServiceProvider).asData?.value;
  if (storage == null) {
    throw Exception('StorageService not initialized');
  }
  return CacheManager(storage);
});

// Theme mode provider
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  final prefs = ref.watch(userPreferencesProvider);
  return ThemeModeNotifier(prefs);
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  final UserPreferences _prefs;

  ThemeModeNotifier(this._prefs) : super(_prefs.getThemeMode());

  Future<void> setThemeMode(ThemeMode mode) async {
    await _prefs.setThemeMode(mode);
    state = mode;
  }
}

// Language provider
final languageProvider = StateNotifierProvider<LanguageNotifier, String>((ref) {
  final prefs = ref.watch(userPreferencesProvider);
  return LanguageNotifier(prefs);
});

class LanguageNotifier extends StateNotifier<String> {
  final UserPreferences _prefs;

  LanguageNotifier(this._prefs) : super(_prefs.getLanguage());

  Future<void> setLanguage(String languageCode) async {
    await _prefs.setLanguage(languageCode);
    state = languageCode;
  }
}

// Notifications enabled provider
final notificationsEnabledProvider = StateNotifierProvider<NotificationsNotifier, bool>((ref) {
  final prefs = ref.watch(userPreferencesProvider);
  return NotificationsNotifier(prefs);
});

class NotificationsNotifier extends StateNotifier<bool> {
  final UserPreferences _prefs;

  NotificationsNotifier(this._prefs) : super(_prefs.getNotificationsEnabled());

  Future<void> toggle() async {
    final newValue = !state;
    await _prefs.setNotificationsEnabled(newValue);
    state = newValue;
  }

  Future<void> setValue(bool value) async {
    await _prefs.setNotificationsEnabled(value);
    state = value;
  }
}

// Favorites provider
final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<String>>((ref) {
  final prefs = ref.watch(userPreferencesProvider);
  return FavoritesNotifier(prefs);
});

class FavoritesNotifier extends StateNotifier<List<String>> {
  final UserPreferences _prefs;

  FavoritesNotifier(this._prefs) : super(_prefs.getFavoriteBusinesses());

  Future<void> addFavorite(String businessId) async {
    await _prefs.addFavoriteBusiness(businessId);
    state = _prefs.getFavoriteBusinesses();
  }

  Future<void> removeFavorite(String businessId) async {
    await _prefs.removeFavoriteBusiness(businessId);
    state = _prefs.getFavoriteBusinesses();
  }

  bool isFavorite(String businessId) {
    return state.contains(businessId);
  }

  Future<void> clearAll() async {
    await _prefs.clearFavorites();
    state = [];
  }
}

// Search history provider
final searchHistoryProvider = StateNotifierProvider<SearchHistoryNotifier, List<String>>((ref) {
  final prefs = ref.watch(userPreferencesProvider);
  return SearchHistoryNotifier(prefs);
});

class SearchHistoryNotifier extends StateNotifier<List<String>> {
  final UserPreferences _prefs;

  SearchHistoryNotifier(this._prefs) : super(_prefs.getSearchHistory());

  Future<void> addSearch(String query) async {
    await _prefs.addSearchQuery(query);
    state = _prefs.getSearchHistory();
  }

  Future<void> clearHistory() async {
    await _prefs.clearSearchHistory();
    state = [];
  }
}
