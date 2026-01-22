import 'package:dio/dio.dart';

import '../../../core/network/api_config.dart';
import '../../../core/storage/cache_manager.dart';
import '../../models/appointment_model.dart';
import '../../network/api_client.dart';
import '../result.dart';

/// API Appointment Repository
/// Handles appointment-related API calls
class ApiAppointmentRepository {
  final ApiClient _apiClient = ApiClient.instance;
  final CacheManager? _cacheManager;

  ApiAppointmentRepository({CacheManager? cacheManager})
      : _cacheManager = cacheManager;

  /// Get all appointments for a user
  Future<Result<List<AppointmentModel>>> getUserAppointments({
    required String userId,
    AppointmentStatus? status,
  }) async {
    try {
      final path = ApiConfig.userAppointments.replaceAll('{userId}', userId);
      final queryParams = <String, dynamic>{};

      if (status != null) {
        queryParams['status'] = status.name;
      }

      final response = await _apiClient.get(
        path,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? response.data;
        final appointments = data
            .map((json) =>
                AppointmentModel.fromJson(json as Map<String, dynamic>))
            .toList();

        // Cache the results (only if no status filter)
        if (_cacheManager != null && status == null) {
          await _cacheManager!.cacheAppointments(userId, appointments);
        }

        return Result.success(appointments);
      } else {
        // Fallback to cache on error
        if (_cacheManager != null && status == null) {
          final cached = _cacheManager!.getCachedAppointments(userId);
          if (cached != null) return Result.success(cached);
        }
        return Result.failure('Randevular yüklenemedi');
      }
    } on DioException catch (e) {
      // Offline fallback
      if (_cacheManager != null && status == null) {
        final cached = _cacheManager!.getCachedAppointments(userId);
        if (cached != null) return Result.success(cached);
      }
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Get appointments for a business
  Future<Result<List<AppointmentModel>>> getBusinessAppointments({
    required String businessId,
    AppointmentStatus? status,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final path =
          ApiConfig.businessAppointments.replaceAll('{businessId}', businessId);
      final queryParams = <String, dynamic>{};

      if (status != null) {
        queryParams['status'] = status.name;
      }
      if (startDate != null) {
        queryParams['start_date'] = startDate.toIso8601String();
      }
      if (endDate != null) {
        queryParams['end_date'] = endDate.toIso8601String();
      }

      final response = await _apiClient.get(
        path,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? response.data;
        final appointments = data
            .map((json) =>
                AppointmentModel.fromJson(json as Map<String, dynamic>))
            .toList();

        return Result.success(appointments);
      } else {
        return Result.failure('Randevular yüklenemedi');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Get appointment by ID
  Future<Result<AppointmentModel>> getAppointmentById(String id) async {
    try {
      final response = await _apiClient.get('${ApiConfig.appointments}/$id');

      if (response.statusCode == 200) {
        final appointment = AppointmentModel.fromJson(
          response.data['data'] ?? response.data,
        );
        return Result.success(appointment);
      } else {
        return Result.failure('Randevu bulunamadı');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Create new appointment
  Future<Result<AppointmentModel>> createAppointment({
    required String businessId,
    required String serviceId,
    required String userId,
    String? employeeId,
    required DateTime appointmentDate,
    required String timeSlot,
    String? notes,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiConfig.appointments,
        data: {
          'business_id': businessId,
          'service_id': serviceId,
          'user_id': userId,
          'employee_id': employeeId,
          'appointment_date': appointmentDate.toIso8601String(),
          'time_slot': timeSlot,
          'notes': notes,
          'status': AppointmentStatus.pending.name,
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final appointment = AppointmentModel.fromJson(
          response.data['data'] ?? response.data,
        );
        return Result.success(appointment);
      } else {
        return Result.failure('Randevu oluşturulamadı');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Randevu oluşturulamadı');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Update appointment status
  Future<Result<AppointmentModel>> updateAppointmentStatus({
    required String appointmentId,
    required AppointmentStatus status,
  }) async {
    try {
      final response = await _apiClient.put(
        '${ApiConfig.appointments}/$appointmentId',
        data: {'status': status.name},
      );

      if (response.statusCode == 200) {
        final appointment = AppointmentModel.fromJson(
          response.data['data'] ?? response.data,
        );
        return Result.success(appointment);
      } else {
        return Result.failure('Randevu durumu güncellenemedi');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Cancel appointment
  Future<Result<AppointmentModel>> cancelAppointment({
    required String appointmentId,
    String? cancellationReason,
  }) async {
    try {
      final path =
          ApiConfig.cancelAppointment.replaceAll('{id}', appointmentId);
      final response = await _apiClient.post(
        path,
        data: {
          'reason': cancellationReason,
        },
      );

      if (response.statusCode == 200) {
        final appointment = AppointmentModel.fromJson(
          response.data['data'] ?? response.data,
        );
        return Result.success(appointment);
      } else {
        return Result.failure('Randevu iptal edilemedi');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Randevu iptal edilemedi');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Delete appointment (admin only)
  Future<Result<bool>> deleteAppointment(String appointmentId) async {
    try {
      final response = await _apiClient.delete(
        '${ApiConfig.appointments}/$appointmentId',
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return Result.success(true);
      } else {
        return Result.failure('Randevu silinemedi');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Confirm appointment
  Future<Result<AppointmentModel>> confirmAppointment(
      String appointmentId) async {
    return updateAppointmentStatus(
      appointmentId: appointmentId,
      status: AppointmentStatus.confirmed,
    );
  }

  /// Complete appointment
  Future<Result<AppointmentModel>> completeAppointment(
      String appointmentId) async {
    return updateAppointmentStatus(
      appointmentId: appointmentId,
      status: AppointmentStatus.completed,
    );
  }

  /// Get upcoming appointments for a user
  Future<Result<List<AppointmentModel>>> getUpcomingAppointments({
    required String userId,
  }) async {
    try {
      final path = ApiConfig.userAppointments.replaceAll('{userId}', userId);
      final response = await _apiClient.get(
        path,
        queryParameters: {
          'status': 'confirmed,pending',
          'start_date': DateTime.now().toIso8601String(),
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? response.data;
        final appointments = data
            .map((json) =>
                AppointmentModel.fromJson(json as Map<String, dynamic>))
            .toList();

        // Sort by date
        appointments.sort((a, b) => a.dateTime.compareTo(b.dateTime));

        return Result.success(appointments);
      } else {
        return Result.failure('Yaklaşan randevular yüklenemedi');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Get past appointments for a user
  Future<Result<List<AppointmentModel>>> getPastAppointments({
    required String userId,
  }) async {
    try {
      final path = ApiConfig.userAppointments.replaceAll('{userId}', userId);
      final response = await _apiClient.get(
        path,
        queryParameters: {
          'status': 'completed,cancelled',
          'end_date': DateTime.now().toIso8601String(),
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? response.data;
        final appointments = data
            .map((json) =>
                AppointmentModel.fromJson(json as Map<String, dynamic>))
            .toList();

        // Sort by date (most recent first)
        appointments.sort((a, b) => b.dateTime.compareTo(a.dateTime));

        return Result.success(appointments);
      } else {
        return Result.failure('Geçmiş randevular yüklenemedi');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
