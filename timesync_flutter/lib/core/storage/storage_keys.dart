/// Storage keys for SharedPreferences
/// Centralized key management for consistency
class StorageKeys {
  // --- Sensitive Keys (Use setSecureString/getSecureString) ---
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String userId = 'user_id';
  // -----------------------------------------------------------

  // Auth keys (Normal)
  static const String userRole = 'user_role';
  static const String userProfile = 'user_profile';
  static const String isLoggedIn = 'is_logged_in';

  // User preferences
  static const String themeMode = 'theme_mode'; // 'light', 'dark', 'system'
  static const String language = 'language'; // 'tr', 'en'
  static const String notificationsEnabled = 'notifications_enabled';
  static const String emailNotifications = 'email_notifications';
  static const String pushNotifications = 'push_notifications';
  static const String reminderTime =
      'reminder_time'; // minutes before appointment

  // Onboarding
  static const String hasCompletedOnboarding = 'has_completed_onboarding';
  static const String firstLaunch = 'first_launch';

  // Cache keys
  static const String cachedBusinesses = 'cached_businesses';
  static const String cachedBusinessesTimestamp = 'cached_businesses_timestamp';
  static const String cachedFeaturedBusinesses = 'cached_featured_businesses';
  static const String cachedFeaturedBusinessesTimestamp =
      'cached_featured_businesses_timestamp';
  static const String cachedCategories = 'cached_categories';
  static const String cachedCategoriesTimestamp = 'cached_categories_timestamp';
  static const String cachedReviews = 'cached_reviews';
  static const String cachedReviewsTimestamp = 'cached_reviews_timestamp';
  static const String cachedAppointments = 'cached_appointments';
  static const String cachedAppointmentsTimestamp =
      'cached_appointments_timestamp';
  static const String cachedUserProfile = 'cached_user_profile';
  static const String cachedUserProfileTimestamp =
      'cached_user_profile_timestamp';

  // Search history
  static const String recentSearches = 'recent_searches';
  static const int maxSearchHistory = 10;

  // Favorites
  static const String favoriteBusinesses = 'favorite_businesses';

  // Last selected
  static const String lastSelectedCategory = 'last_selected_category';
  static const String lastSelectedBusinessId = 'last_selected_business_id';

  // App state
  static const String lastAppVersion = 'last_app_version';
  static const String lastUpdateCheck = 'last_update_check';

  // Cache expiry durations (in minutes)
  static const int defaultCacheExpiry = 5;
  static const int businessesCacheExpiry = 15;
  static const int categoriesCacheExpiry = 60;
  static const int userProfileCacheExpiry = 30;
}
