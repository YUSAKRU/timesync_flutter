import '../../data/models/appointment_model.dart';
import '../../data/repositories/api/api_appointment_repository.dart';
import '../../data/repositories/mock/mock_appointment_repository.dart';
import '../../data/repositories/result.dart';
import '../config/app_environment.dart';
import '../storage/cache_manager.dart';

/// Appointment Repository Factory
/// Returns mock or API repository based on environment
abstract class IAppointmentRepository {
  Future<Result<List<AppointmentModel>>> getUserAppointments({
    required String userId,
    AppointmentStatus? status,
  });

  Future<Result<AppointmentModel>> getAppointmentById(String id);

  Future<Result<AppointmentModel>> createAppointment({
    required String businessId,
    required String serviceId,
    required String userId,
    String? employeeId,
    required DateTime appointmentDate,
    required String timeSlot,
    String? notes,
  });

  Future<Result<AppointmentModel>> updateAppointmentStatus({
    required String appointmentId,
    required AppointmentStatus status,
  });

  Future<Result<AppointmentModel>> cancelAppointment({
    required String appointmentId,
    String? cancellationReason,
  });

  Future<Result<List<AppointmentModel>>> getUpcomingAppointments({
    required String userId,
  });

  Future<Result<List<AppointmentModel>>> getPastAppointments({
    required String userId,
  });
}

class AppointmentRepositoryFactory {
  static IAppointmentRepository create({CacheManager? cacheManager}) {
    if (AppEnvironment.useMockData) {
      final mock = MockAppointmentRepository();
      return _MockAppointmentRepositoryAdapter(mock);
    } else {
      return _ApiAppointmentRepositoryAdapter(cacheManager: cacheManager);
    }
  }
}

// Adapter for MockAppointmentRepository to match interface
class _MockAppointmentRepositoryAdapter implements IAppointmentRepository {
  final MockAppointmentRepository _mock;

  _MockAppointmentRepositoryAdapter(this._mock);

  @override
  Future<Result<List<AppointmentModel>>> getUserAppointments({
    required String userId,
    AppointmentStatus? status,
  }) {
    return _mock.getUserAppointments(userId: userId, status: status);
  }

  @override
  Future<Result<AppointmentModel>> getAppointmentById(String id) {
    return _mock.getAppointmentById(id);
  }

  @override
  Future<Result<AppointmentModel>> createAppointment({
    required String businessId,
    required String serviceId,
    required String userId,
    String? employeeId,
    required DateTime appointmentDate,
    required String timeSlot,
    String? notes,
  }) {
    return _mock.createAppointment(
      businessId: businessId,
      serviceId: serviceId,
      userId: userId,
      employeeId: employeeId,
      appointmentDate: appointmentDate,
      timeSlot: timeSlot,
      notes: notes,
    );
  }

  @override
  Future<Result<AppointmentModel>> updateAppointmentStatus({
    required String appointmentId,
    required AppointmentStatus status,
  }) {
    return _mock.updateAppointmentStatus(
      appointmentId: appointmentId,
      newStatus: status,
    );
  }

  @override
  Future<Result<AppointmentModel>> cancelAppointment({
    required String appointmentId,
    String? cancellationReason,
  }) {
    return _mock.cancelAppointment(
      appointmentId: appointmentId,
      cancellationReason: cancellationReason,
    );
  }

  @override
  Future<Result<List<AppointmentModel>>> getUpcomingAppointments({
    required String userId,
  }) {
    return _mock.getUpcomingAppointments(userId: userId);
  }

  @override
  Future<Result<List<AppointmentModel>>> getPastAppointments({
    required String userId,
  }) {
    return _mock.getPastAppointments(userId: userId);
  }
}

// Adapter to match interface
class _ApiAppointmentRepositoryAdapter implements IAppointmentRepository {
  final ApiAppointmentRepository _repo;

  _ApiAppointmentRepositoryAdapter({CacheManager? cacheManager})
      : _repo = ApiAppointmentRepository(cacheManager: cacheManager);

  @override
  Future<Result<List<AppointmentModel>>> getUserAppointments({
    required String userId,
    AppointmentStatus? status,
  }) {
    return _repo.getUserAppointments(userId: userId, status: status);
  }

  @override
  Future<Result<AppointmentModel>> getAppointmentById(String id) {
    return _repo.getAppointmentById(id);
  }

  @override
  Future<Result<AppointmentModel>> createAppointment({
    required String businessId,
    required String serviceId,
    required String userId,
    String? employeeId,
    required DateTime appointmentDate,
    required String timeSlot,
    String? notes,
  }) {
    return _repo.createAppointment(
      businessId: businessId,
      serviceId: serviceId,
      userId: userId,
      employeeId: employeeId,
      appointmentDate: appointmentDate,
      timeSlot: timeSlot,
      notes: notes,
    );
  }

  @override
  Future<Result<AppointmentModel>> updateAppointmentStatus({
    required String appointmentId,
    required AppointmentStatus status,
  }) {
    return _repo.updateAppointmentStatus(
      appointmentId: appointmentId,
      status: status,
    );
  }

  @override
  Future<Result<AppointmentModel>> cancelAppointment({
    required String appointmentId,
    String? cancellationReason,
  }) {
    return _repo.cancelAppointment(
      appointmentId: appointmentId,
      cancellationReason: cancellationReason,
    );
  }

  @override
  Future<Result<List<AppointmentModel>>> getUpcomingAppointments({
    required String userId,
  }) {
    return _repo.getUpcomingAppointments(userId: userId);
  }

  @override
  Future<Result<List<AppointmentModel>>> getPastAppointments({
    required String userId,
  }) {
    return _repo.getPastAppointments(userId: userId);
  }
}
