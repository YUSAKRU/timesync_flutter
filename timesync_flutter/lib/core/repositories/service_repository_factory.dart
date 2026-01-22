import '../../data/models/service_model.dart';
import '../../data/models/time_slot_model.dart';
import '../../data/repositories/api/api_service_repository.dart';
import '../../data/repositories/mock/mock_service_repository.dart';
import '../../data/repositories/result.dart';
import '../config/app_environment.dart';
import '../storage/cache_manager.dart';

/// Service Repository Factory
/// Returns mock or API repository based on environment
abstract class IServiceRepository {
  Future<Result<List<ServiceModel>>> getBusinessServices({
    required String businessId,
    bool activeOnly = false,
  });

  Future<Result<ServiceModel>> getServiceById(String id);

  Future<Result<List<TimeSlotModel>>> getAvailableTimeSlots({
    required String businessId,
    required String serviceId,
    required DateTime date,
    String? employeeId,
  });
}

class ServiceRepositoryFactory {
  static IServiceRepository create({CacheManager? cacheManager}) {
    if (AppEnvironment.useMockData) {
      final mock = MockServiceRepository();
      return _MockServiceRepositoryAdapter(mock);
    } else {
      return _ApiServiceRepositoryAdapter(cacheManager: cacheManager);
    }
  }
}

// Adapter to match IServiceRepository interface
class _MockServiceRepositoryAdapter implements IServiceRepository {
  final MockServiceRepository _mock;

  _MockServiceRepositoryAdapter(this._mock);

  @override
  Future<Result<List<ServiceModel>>> getBusinessServices({
    required String businessId,
    bool activeOnly = false,
  }) {
    return _mock.getBusinessServices(
      businessId: businessId,
      activeOnly: activeOnly,
    );
  }

  @override
  Future<Result<ServiceModel>> getServiceById(String id) {
    return _mock.getServiceById(id);
  }

  @override
  Future<Result<List<TimeSlotModel>>> getAvailableTimeSlots({
    required String businessId,
    required String serviceId,
    required DateTime date,
    String? employeeId,
  }) {
    return _mock.getAvailableTimeSlots(
      businessId: businessId,
      serviceId: serviceId,
      date: date,
      employeeId: employeeId,
    );
  }
}

// Adapter to match interface
class _ApiServiceRepositoryAdapter implements IServiceRepository {
  final ApiServiceRepository _repo;

  _ApiServiceRepositoryAdapter({CacheManager? cacheManager})
      : _repo = ApiServiceRepository(cacheManager: cacheManager);

  @override
  Future<Result<List<ServiceModel>>> getBusinessServices({
    required String businessId,
    bool activeOnly = false,
  }) {
    return _repo.getBusinessServices(
      businessId: businessId,
      activeOnly: activeOnly,
    );
  }

  @override
  Future<Result<ServiceModel>> getServiceById(String id) {
    return _repo.getServiceById(id);
  }

  @override
  Future<Result<List<TimeSlotModel>>> getAvailableTimeSlots({
    required String businessId,
    required String serviceId,
    required DateTime date,
    String? employeeId,
  }) {
    return _repo.getAvailableTimeSlots(
      businessId: businessId,
      serviceId: serviceId,
      date: date,
      employeeId: employeeId,
    );
  }
}
