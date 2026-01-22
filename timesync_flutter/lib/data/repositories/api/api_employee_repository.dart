import 'package:dio/dio.dart';
import '../../models/employee_model.dart';
import '../../network/api_client.dart';
import '../../../core/network/api_config.dart';
import '../result.dart';

/// API Employee Repository
/// Handles employee-related API calls
class ApiEmployeeRepository {
  final ApiClient _apiClient = ApiClient.instance;

  /// Get all employees for a business
  Future<Result<List<EmployeeModel>>> getBusinessEmployees({
    required String businessId,
    bool activeOnly = false,
  }) async {
    try {
      final path = ApiConfig.businessEmployees.replaceAll('{businessId}', businessId);
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
        final employees = data
            .map((json) => EmployeeModel.fromJson(json as Map<String, dynamic>))
            .toList();
        
        return Result.success(employees);
      } else {
        return Result.failure('Çalışanlar yüklenemedi');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Get employee by ID
  Future<Result<EmployeeModel>> getEmployeeById(String id) async {
    try {
      final response = await _apiClient.get('${ApiConfig.employees}/$id');

      if (response.statusCode == 200) {
        final employee = EmployeeModel.fromJson(
          response.data['data'] ?? response.data,
        );
        return Result.success(employee);
      } else {
        return Result.failure('Çalışan bulunamadı');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Get employees for a specific service
  Future<Result<List<EmployeeModel>>> getServiceEmployees({
    required String serviceId,
  }) async {
    try {
      final response = await _apiClient.get(
        '${ApiConfig.employees}/service/$serviceId',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? response.data;
        final employees = data
            .map((json) => EmployeeModel.fromJson(json as Map<String, dynamic>))
            .toList();
        
        return Result.success(employees);
      } else {
        return Result.failure('Çalışanlar yüklenemedi');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Create employee (business owner/admin only)
  Future<Result<EmployeeModel>> createEmployee({
    required String businessId,
    required String userId,
    required String name,
    required String title,
    List<String>? specialties,
    String? photoUrl,
    bool isActive = true,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiConfig.employees,
        data: {
          'business_id': businessId,
          'user_id': userId,
          'name': name,
          'title': title,
          'specialties': specialties ?? [],
          'photo_url': photoUrl,
          'is_active': isActive,
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final employee = EmployeeModel.fromJson(
          response.data['data'] ?? response.data,
        );
        return Result.success(employee);
      } else {
        return Result.failure('Çalışan oluşturulamadı');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Update employee
  Future<Result<EmployeeModel>> updateEmployee({
    required String employeeId,
    String? name,
    String? title,
    List<String>? specialties,
    String? photoUrl,
    bool? isActive,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (name != null) data['name'] = name;
      if (title != null) data['title'] = title;
      if (specialties != null) data['specialties'] = specialties;
      if (photoUrl != null) data['photo_url'] = photoUrl;
      if (isActive != null) data['is_active'] = isActive;

      final response = await _apiClient.put(
        '${ApiConfig.employees}/$employeeId',
        data: data,
      );

      if (response.statusCode == 200) {
        final employee = EmployeeModel.fromJson(
          response.data['data'] ?? response.data,
        );
        return Result.success(employee);
      } else {
        return Result.failure('Çalışan güncellenemedi');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Delete employee
  Future<Result<bool>> deleteEmployee(String employeeId) async {
    try {
      final response = await _apiClient.delete(
        '${ApiConfig.employees}/$employeeId',
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return Result.success(true);
      } else {
        return Result.failure('Çalışan silinemedi');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Toggle employee active status
  Future<Result<EmployeeModel>> toggleEmployeeStatus({
    required String employeeId,
    required bool isActive,
  }) async {
    return updateEmployee(
      employeeId: employeeId,
      isActive: isActive,
    );
  }

  /// Add service to employee
  Future<Result<EmployeeModel>> addServiceToEmployee({
    required String employeeId,
    required String serviceId,
  }) async {
    try {
      final response = await _apiClient.post(
        '${ApiConfig.employees}/$employeeId/services',
        data: {'service_id': serviceId},
      );

      if (response.statusCode == 200) {
        final employee = EmployeeModel.fromJson(
          response.data['data'] ?? response.data,
        );
        return Result.success(employee);
      } else {
        return Result.failure('Hizmet eklenemedi');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Remove service from employee
  Future<Result<EmployeeModel>> removeServiceFromEmployee({
    required String employeeId,
    required String serviceId,
  }) async {
    try {
      final response = await _apiClient.delete(
        '${ApiConfig.employees}/$employeeId/services/$serviceId',
      );

      if (response.statusCode == 200) {
        final employee = EmployeeModel.fromJson(
          response.data['data'] ?? response.data,
        );
        return Result.success(employee);
      } else {
        return Result.failure('Hizmet kaldırılamadı');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
