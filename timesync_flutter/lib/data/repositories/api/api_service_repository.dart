import 'package:dio/dio.dart';

import '../../../core/network/api_config.dart';
import '../../../core/storage/cache_manager.dart';
import '../../models/service_model.dart';
import '../../models/time_slot_model.dart';
import '../../network/api_client.dart';
import '../result.dart';

/// API Service Repository
/// Handles service and time slot-related API calls
class ApiServiceRepository {
  final ApiClient _apiClient = ApiClient.instance;
  final CacheManager? _cacheManager;

  ApiServiceRepository({CacheManager? cacheManager})
      : _cacheManager = cacheManager;

  /// Get all services for a business
  Future<Result<List<ServiceModel>>> getBusinessServices({
    required String businessId,
    bool activeOnly = false,
  }) async {
    try {
      final path =
          ApiConfig.businessServices.replaceAll('{businessId}', businessId);
      final queryParams = <String, dynamic>{};

      if (activeOnly) {
        queryParams['is_active'] = true;
      }

      final response = await _apiClient.get(
        path,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? response.data;
        final services = data
            .map((json) => ServiceModel.fromJson(json as Map<String, dynamic>))
            .toList();

        // Cache the services (only if not activeOnly or some other specific condition)
        if (_cacheManager != null && !activeOnly) {
          final key = 'cached_services_$businessId';
          await _cacheManager!.setCache(
              key, services.map((e) => e.toJson()).toList(),
              timestampKey: '${key}_timestamp');
        }

        return Result.success(services);
      } else {
        // Fallback to cache on error
        if (_cacheManager != null && !activeOnly) {
          final key = 'cached_services_$businessId';
          final cached =
              _cacheManager!.getCache(key, timestampKey: '${key}_timestamp')
                  as List<Map<String, dynamic>>?;
          if (cached != null) {
            return Result.success(
                cached.map((e) => ServiceModel.fromJson(e)).toList());
          }
        }
        return Result.failure('Hizmetler yüklenemedi');
      }
    } on DioException catch (e) {
      // Offline fallback
      if (_cacheManager != null && !activeOnly) {
        final key = 'cached_services_$businessId';
        final cached =
            _cacheManager!.getCache(key, timestampKey: '${key}_timestamp')
                as List<Map<String, dynamic>>?;
        if (cached != null) {
          return Result.success(
              cached.map((e) => ServiceModel.fromJson(e)).toList());
        }
      }
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Get service by ID
  Future<Result<ServiceModel>> getServiceById(String id) async {
    try {
      final response = await _apiClient.get('${ApiConfig.services}/$id');

      if (response.statusCode == 200) {
        final service = ServiceModel.fromJson(
          response.data['data'] ?? response.data,
        );
        return Result.success(service);
      } else {
        return Result.failure('Hizmet bulunamadı');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Create service (business owner/admin only)
  Future<Result<ServiceModel>> createService({
    required String businessId,
    required String name,
    required String description,
    required double price,
    required int duration,
    String? category,
    bool isActive = true,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiConfig.services,
        data: {
          'business_id': businessId,
          'name': name,
          'description': description,
          'price': price,
          'duration': duration,
          'category': category,
          'is_active': isActive,
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final service = ServiceModel.fromJson(
          response.data['data'] ?? response.data,
        );
        return Result.success(service);
      } else {
        return Result.failure('Hizmet oluşturulamadı');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Update service
  Future<Result<ServiceModel>> updateService({
    required String serviceId,
    String? name,
    String? description,
    double? price,
    int? duration,
    String? category,
    bool? isActive,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (name != null) data['name'] = name;
      if (description != null) data['description'] = description;
      if (price != null) data['price'] = price;
      if (duration != null) data['duration'] = duration;
      if (category != null) data['category'] = category;
      if (isActive != null) data['is_active'] = isActive;

      final response = await _apiClient.put(
        '${ApiConfig.services}/$serviceId',
        data: data,
      );

      if (response.statusCode == 200) {
        final service = ServiceModel.fromJson(
          response.data['data'] ?? response.data,
        );
        return Result.success(service);
      } else {
        return Result.failure('Hizmet güncellenemedi');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Delete service
  Future<Result<bool>> deleteService(String serviceId) async {
    try {
      final response = await _apiClient.delete(
        '${ApiConfig.services}/$serviceId',
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return Result.success(true);
      } else {
        return Result.failure('Hizmet silinemedi');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Get available time slots for a service
  Future<Result<List<TimeSlotModel>>> getAvailableTimeSlots({
    required String businessId,
    required String serviceId,
    required DateTime date,
    String? employeeId,
  }) async {
    try {
      const path = ApiConfig.timeSlots;
      final response = await _apiClient.get(
        path,
        queryParameters: {
          'business_id': businessId,
          'service_id': serviceId,
          'date': date.toIso8601String().split('T')[0], // YYYY-MM-DD
          if (employeeId != null) 'employee_id': employeeId,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? response.data;
        final timeSlots = data
            .map((json) => TimeSlotModel.fromJson(json as Map<String, dynamic>))
            .toList();

        return Result.success(timeSlots);
      } else {
        return Result.failure('Uygun saatler yüklenemedi');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Get business working hours
  Future<Result<Map<String, dynamic>>> getWorkingHours({
    required String businessId,
  }) async {
    try {
      final response = await _apiClient.get(
        '${ApiConfig.businesses}/$businessId/working-hours',
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] ?? response.data;
        return Result.success(data as Map<String, dynamic>);
      } else {
        return Result.failure('Çalışma saatleri yüklenemedi');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Update working hours (business owner only)
  Future<Result<Map<String, dynamic>>> updateWorkingHours({
    required String businessId,
    required Map<String, dynamic> workingHours,
  }) async {
    try {
      final response = await _apiClient.put(
        '${ApiConfig.businesses}/$businessId/working-hours',
        data: workingHours,
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] ?? response.data;
        return Result.success(data as Map<String, dynamic>);
      } else {
        return Result.failure('Çalışma saatleri güncellenemedi');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Block time slot (business owner only)
  Future<Result<bool>> blockTimeSlot({
    required String businessId,
    required DateTime date,
    required String startTime,
    required String endTime,
    String? reason,
  }) async {
    try {
      final response = await _apiClient.post(
        '${ApiConfig.timeSlots}/block',
        data: {
          'business_id': businessId,
          'date': date.toIso8601String().split('T')[0],
          'start_time': startTime,
          'end_time': endTime,
          'reason': reason,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Result.success(true);
      } else {
        return Result.failure('Saat blokelemedi');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Unblock time slot
  Future<Result<bool>> unblockTimeSlot({
    required String timeSlotId,
  }) async {
    try {
      final response = await _apiClient.delete(
        '${ApiConfig.timeSlots}/$timeSlotId/block',
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return Result.success(true);
      } else {
        return Result.failure('Bloke kaldırılamadı');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Get service categories for a business
  Future<Result<List<String>>> getServiceCategories({
    required String businessId,
  }) async {
    try {
      final response = await _apiClient.get(
        '${ApiConfig.businesses}/$businessId/service-categories',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? response.data;
        final categories = data.map((e) => e.toString()).toList();
        return Result.success(categories);
      } else {
        return Result.failure('Kategoriler yüklenemedi');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
