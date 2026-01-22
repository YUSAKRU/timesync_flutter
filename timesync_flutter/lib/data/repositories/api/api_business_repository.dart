import 'package:dio/dio.dart';

import '../../../core/network/api_config.dart';
import '../../../core/storage/cache_manager.dart';
import '../../models/business_model.dart';
import '../../network/api_client.dart';
import '../result.dart';

/// API Business Repository
/// Handles business-related API calls
class ApiBusinessRepository {
  final ApiClient _apiClient = ApiClient.instance;
  final CacheManager? _cacheManager;

  ApiBusinessRepository({CacheManager? cacheManager})
      : _cacheManager = cacheManager;

  /// Get all businesses with optional filters
  Future<Result<List<BusinessModel>>> getBusinesses({
    String? category,
    String? searchQuery,
    int? limit,
    int? offset,
  }) async {
    try {
      final queryParams = <String, dynamic>{};

      if (category != null && category != 'Tümü') {
        queryParams['category'] = category;
      }
      if (searchQuery != null && searchQuery.isNotEmpty) {
        queryParams['search'] = searchQuery;
      }
      if (limit != null) {
        queryParams['limit'] = limit;
      }
      if (offset != null) {
        queryParams['offset'] = offset;
      }

      final response = await _apiClient.get(
        ApiConfig.businesses,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? response.data;
        final businesses = data
            .map((json) => BusinessModel.fromJson(json as Map<String, dynamic>))
            .toList();

        // Cache the results (only if no filters)
        if (_cacheManager != null &&
            category == null &&
            searchQuery == null &&
            offset == null) {
          await _cacheManager!.cacheBusinesses(businesses);
        }

        return Result.success(businesses);
      } else {
        // Fallback to cache on error
        if (_cacheManager != null && category == null && searchQuery == null) {
          final cached = _cacheManager!.getCachedBusinesses();
          if (cached != null) return Result.success(cached);
        }
        return Result.failure('İşletmeler yüklenemedi');
      }
    } on DioException catch (e) {
      // Offline fallback
      if (_cacheManager != null && category == null && searchQuery == null) {
        final cached = _cacheManager!.getCachedBusinesses();
        if (cached != null) return Result.success(cached);
      }
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Get business by ID
  Future<Result<BusinessModel>> getBusinessById(String id) async {
    try {
      final path = ApiConfig.businessById.replaceAll('{id}', id);
      final response = await _apiClient.get(path);

      if (response.statusCode == 200) {
        final business = BusinessModel.fromJson(
          response.data['data'] ?? response.data,
        );

        // Cache the business
        if (_cacheManager != null) {
          await _cacheManager!.cacheBusiness(business);
        }

        return Result.success(business);
      } else {
        // Fallback to cache on error
        if (_cacheManager != null) {
          final cached = _cacheManager!.getCachedBusiness(id);
          if (cached != null) return Result.success(cached);
        }
        return Result.failure('İşletme bulunamadı');
      }
    } on DioException catch (e) {
      // Offline fallback
      if (_cacheManager != null) {
        final cached = _cacheManager!.getCachedBusiness(id);
        if (cached != null) return Result.success(cached);
      }
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Get featured/popular businesses
  Future<Result<List<BusinessModel>>> getFeaturedBusinesses({
    int limit = 5,
  }) async {
    try {
      final response = await _apiClient.get(
        ApiConfig.featuredBusinesses,
        queryParameters: {'limit': limit},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? response.data;
        final businesses = data
            .map((json) => BusinessModel.fromJson(json as Map<String, dynamic>))
            .toList();

        // Cache the results
        if (_cacheManager != null) {
          await _cacheManager!.cacheFeaturedBusinesses(businesses);
        }

        return Result.success(businesses);
      } else {
        // Fallback to cache on error
        if (_cacheManager != null) {
          final cached = _cacheManager!.getCachedFeaturedBusinesses();
          if (cached != null) return Result.success(cached);
        }
        return Result.failure('Öne çıkan işletmeler yüklenemedi');
      }
    } on DioException catch (e) {
      // Offline fallback
      if (_cacheManager != null) {
        final cached = _cacheManager!.getCachedFeaturedBusinesses();
        if (cached != null) return Result.success(cached);
      }
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Search businesses
  Future<Result<List<BusinessModel>>> searchBusinesses({
    required String query,
    String? category,
    double? latitude,
    double? longitude,
    double? radius,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'q': query,
      };

      if (category != null && category != 'Tümü') {
        queryParams['category'] = category;
      }
      if (latitude != null) {
        queryParams['lat'] = latitude;
      }
      if (longitude != null) {
        queryParams['lng'] = longitude;
      }
      if (radius != null) {
        queryParams['radius'] = radius;
      }

      final response = await _apiClient.get(
        ApiConfig.businessSearch,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? response.data;
        final businesses = data
            .map((json) => BusinessModel.fromJson(json as Map<String, dynamic>))
            .toList();

        return Result.success(businesses);
      } else {
        return Result.failure('Arama sonucu bulunamadı');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Create business (admin/business owner only)
  Future<Result<BusinessModel>> createBusiness({
    required Map<String, dynamic> businessData,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiConfig.businesses,
        data: businessData,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final business = BusinessModel.fromJson(
          response.data['data'] ?? response.data,
        );
        return Result.success(business);
      } else {
        return Result.failure('İşletme oluşturulamadı');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Update business
  Future<Result<BusinessModel>> updateBusiness({
    required String id,
    required Map<String, dynamic> businessData,
  }) async {
    try {
      final path = ApiConfig.businessById.replaceAll('{id}', id);
      final response = await _apiClient.put(
        path,
        data: businessData,
      );

      if (response.statusCode == 200) {
        final business = BusinessModel.fromJson(
          response.data['data'] ?? response.data,
        );
        return Result.success(business);
      } else {
        return Result.failure('İşletme güncellenemedi');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Delete business
  Future<Result<bool>> deleteBusiness(String id) async {
    try {
      final path = ApiConfig.businessById.replaceAll('{id}', id);
      final response = await _apiClient.delete(path);

      if (response.statusCode == 200 || response.statusCode == 204) {
        return Result.success(true);
      } else {
        return Result.failure('İşletme silinemedi');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
