import '../../data/models/appointment_model.dart';
import '../../data/models/business_model.dart';
import '../../data/models/review_model.dart';
import '../../data/models/user_model.dart';
import 'storage_keys.dart';
import 'storage_service.dart';

/// Cache manager for businesses and other data
/// Handles caching with expiry times
class CacheManager {
  final StorageService _storage;

  CacheManager(this._storage);

  // Business cache
  Future<bool> cacheBusinesses(List<BusinessModel> businesses) async {
    final jsonList = businesses.map((b) => b.toJson()).toList();
    final success = await _storage.setJsonList(
      StorageKeys.cachedBusinesses,
      jsonList,
    );

    if (success) {
      await _storage.setTimestamp(StorageKeys.cachedBusinessesTimestamp);
    }

    return success;
  }

  List<BusinessModel>? getCachedBusinesses() {
    // Check if cache is expired
    if (_storage.isCacheExpired(
      StorageKeys.cachedBusinessesTimestamp,
      maxAgeInMinutes: StorageKeys.businessesCacheExpiry,
    )) {
      return null;
    }

    final jsonList = _storage.getJsonList(StorageKeys.cachedBusinesses);
    if (jsonList == null) return null;

    try {
      return jsonList.map((json) => BusinessModel.fromJson(json)).toList();
    } catch (e) {
      return null;
    }
  }

  Future<bool> clearBusinessesCache() async {
    await _storage.remove(StorageKeys.cachedBusinesses);
    return await _storage.remove(StorageKeys.cachedBusinessesTimestamp);
  }

  // Featured businesses cache
  Future<bool> cacheFeaturedBusinesses(List<BusinessModel> businesses) async {
    final jsonList = businesses.map((b) => b.toJson()).toList();
    final success = await _storage.setJsonList(
      StorageKeys.cachedFeaturedBusinesses,
      jsonList,
    );

    if (success) {
      await _storage.setTimestamp(
        StorageKeys.cachedFeaturedBusinessesTimestamp,
      );
    }

    return success;
  }

  List<BusinessModel>? getCachedFeaturedBusinesses() {
    // Check if cache is expired
    if (_storage.isCacheExpired(
      StorageKeys.cachedFeaturedBusinessesTimestamp,
      maxAgeInMinutes: StorageKeys.businessesCacheExpiry,
    )) {
      return null;
    }

    final jsonList = _storage.getJsonList(
      StorageKeys.cachedFeaturedBusinesses,
    );
    if (jsonList == null) return null;

    try {
      return jsonList.map((json) => BusinessModel.fromJson(json)).toList();
    } catch (e) {
      return null;
    }
  }

  Future<bool> clearFeaturedBusinessesCache() async {
    await _storage.remove(StorageKeys.cachedFeaturedBusinesses);
    return await _storage.remove(
      StorageKeys.cachedFeaturedBusinessesTimestamp,
    );
  }

  // Categories cache
  Future<bool> cacheCategories(List<String> categories) async {
    final success = await _storage.setStringList(
      StorageKeys.cachedCategories,
      categories,
    );

    if (success) {
      await _storage.setTimestamp(StorageKeys.cachedCategoriesTimestamp);
    }

    return success;
  }

  List<String>? getCachedCategories() {
    // Check if cache is expired
    if (_storage.isCacheExpired(
      StorageKeys.cachedCategoriesTimestamp,
      maxAgeInMinutes: StorageKeys.categoriesCacheExpiry,
    )) {
      return null;
    }

    return _storage.getStringList(StorageKeys.cachedCategories);
  }

  Future<bool> clearCategoriesCache() async {
    await _storage.remove(StorageKeys.cachedCategories);
    return await _storage.remove(StorageKeys.cachedCategoriesTimestamp);
  }

  // Reviews cache
  Future<bool> cacheReviews(
      String businessId, List<ReviewModel> reviews) async {
    final key = '${StorageKeys.cachedReviews}_$businessId';
    final timestampKey = '${StorageKeys.cachedReviewsTimestamp}_$businessId';
    final jsonList = reviews.map((r) => r.toJson()).toList();
    final success = await _storage.setJsonList(key, jsonList);
    if (success) {
      await _storage.setTimestamp(timestampKey);
    }
    return success;
  }

  List<ReviewModel>? getCachedReviews(String businessId) {
    final key = '${StorageKeys.cachedReviews}_$businessId';
    final timestampKey = '${StorageKeys.cachedReviewsTimestamp}_$businessId';
    if (_storage.isCacheExpired(timestampKey, maxAgeInMinutes: 10)) {
      return null;
    }
    final jsonList = _storage.getJsonList(key);
    if (jsonList == null) return null;
    try {
      return jsonList.map((json) => ReviewModel.fromJson(json)).toList();
    } catch (e) {
      return null;
    }
  }

  // Appointments cache
  Future<bool> cacheAppointments(
      String userId, List<AppointmentModel> appointments) async {
    final key = '${StorageKeys.cachedAppointments}_$userId';
    final timestampKey = '${StorageKeys.cachedAppointmentsTimestamp}_$userId';
    final jsonList = appointments.map((a) => a.toJson()).toList();
    final success = await _storage.setJsonList(key, jsonList);
    if (success) {
      await _storage.setTimestamp(timestampKey);
    }
    return success;
  }

  List<AppointmentModel>? getCachedAppointments(String userId) {
    final key = '${StorageKeys.cachedAppointments}_$userId';
    final timestampKey = '${StorageKeys.cachedAppointmentsTimestamp}_$userId';
    if (_storage.isCacheExpired(timestampKey, maxAgeInMinutes: 5)) {
      return null;
    }
    final jsonList = _storage.getJsonList(key);
    if (jsonList == null) return null;
    try {
      return jsonList.map((json) => AppointmentModel.fromJson(json)).toList();
    } catch (e) {
      return null;
    }
  }

  // User Profile cache
  Future<bool> cacheUserProfile(UserModel user) async {
    final success = await _storage.setJson(
      StorageKeys.cachedUserProfile,
      user.toJson(),
    );
    if (success) {
      await _storage.setTimestamp(StorageKeys.cachedUserProfileTimestamp);
    }
    return success;
  }

  UserModel? getCachedUserProfile() {
    if (_storage.isCacheExpired(
      StorageKeys.cachedUserProfileTimestamp,
      maxAgeInMinutes: StorageKeys.userProfileCacheExpiry,
    )) {
      return null;
    }
    final json = _storage.getJson(StorageKeys.cachedUserProfile);
    if (json == null) return null;
    try {
      return UserModel.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  // Generic JSON caching
  Future<bool> setCache(String key, dynamic data,
      {String? timestampKey}) async {
    bool success = false;
    if (data is Map<String, dynamic>) {
      success = await _storage.setJson(key, data);
    } else if (data is List<Map<String, dynamic>>) {
      success = await _storage.setJsonList(key, data);
    }

    if (success && timestampKey != null) {
      await _storage.setTimestamp(timestampKey);
    }
    return success;
  }

  dynamic getCache(String key,
      {String? timestampKey, int maxAgeInMinutes = 5}) {
    if (timestampKey != null &&
        _storage.isCacheExpired(timestampKey,
            maxAgeInMinutes: maxAgeInMinutes)) {
      return null;
    }

    // Try list first then map
    final listData = _storage.getJsonList(key);
    if (listData != null) return listData;

    return _storage.getJson(key);
  }

  // Single business cache (by ID)
  String _businessCacheKey(String businessId) => 'cached_business_$businessId';
  String _businessTimestampKey(String businessId) =>
      'cached_business_${businessId}_timestamp';

  Future<bool> cacheBusiness(BusinessModel business) async {
    final success = await _storage.setJson(
      _businessCacheKey(business.id),
      business.toJson(),
    );

    if (success) {
      await _storage.setTimestamp(_businessTimestampKey(business.id));
    }

    return success;
  }

  BusinessModel? getCachedBusiness(String businessId) {
    // Check if cache is expired
    if (_storage.isCacheExpired(
      _businessTimestampKey(businessId),
      maxAgeInMinutes: StorageKeys.businessesCacheExpiry,
    )) {
      return null;
    }

    final json = _storage.getJson(_businessCacheKey(businessId));
    if (json == null) return null;

    try {
      return BusinessModel.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  Future<bool> clearBusinessCache(String businessId) async {
    await _storage.remove(_businessCacheKey(businessId));
    return await _storage.remove(_businessTimestampKey(businessId));
  }

  // Clear all cache
  Future<bool> clearAllCache() async {
    await clearBusinessesCache();
    await clearFeaturedBusinessesCache();
    await clearCategoriesCache();

    // Clear individual business caches
    final keys = _storage.getKeys();
    for (final key in keys) {
      if (key.startsWith('cached_business_')) {
        await _storage.remove(key);
      }
    }

    return true;
  }

  // Check if any cache exists
  bool hasCachedData() {
    return _storage.containsKey(StorageKeys.cachedBusinesses) ||
        _storage.containsKey(StorageKeys.cachedFeaturedBusinesses) ||
        _storage.containsKey(StorageKeys.cachedCategories);
  }

  // Get cache info (for debugging)
  Map<String, dynamic> getCacheInfo() {
    return {
      'hasBusinessesCache': _storage.containsKey(StorageKeys.cachedBusinesses),
      'businessesCacheAge': _getCacheAge(
        StorageKeys.cachedBusinessesTimestamp,
      ),
      'hasFeaturedCache': _storage.containsKey(
        StorageKeys.cachedFeaturedBusinesses,
      ),
      'featuredCacheAge': _getCacheAge(
        StorageKeys.cachedFeaturedBusinessesTimestamp,
      ),
      'hasCategoriesCache': _storage.containsKey(
        StorageKeys.cachedCategories,
      ),
      'categoriesCacheAge': _getCacheAge(
        StorageKeys.cachedCategoriesTimestamp,
      ),
    };
  }

  String _getCacheAge(String timestampKey) {
    final timestamp = _storage.getTimestamp(timestampKey);
    if (timestamp == null) return 'N/A';

    final age = DateTime.now().difference(timestamp);
    if (age.inMinutes < 1) return '${age.inSeconds}s';
    if (age.inHours < 1) return '${age.inMinutes}m';
    return '${age.inHours}h';
  }
}
