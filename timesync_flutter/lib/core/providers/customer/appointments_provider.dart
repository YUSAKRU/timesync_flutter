import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/appointment_model.dart';
import '../../repositories/appointment_repository_factory.dart';
import '../storage_providers.dart';

class AppointmentsNotifier
    extends StateNotifier<AsyncValue<List<AppointmentModel>>> {
  final IAppointmentRepository _repository;
  final String userId;

  AppointmentsNotifier(this._repository, this.userId)
      : super(const AsyncValue.loading()) {
    loadAppointments();
  }

  Future<void> loadAppointments({AppointmentStatus? status}) async {
    state = const AsyncValue.loading();

    try {
      final result = await _repository.getUserAppointments(
        userId: userId,
        status: status,
      );

      result.when(
        success: (appointments) {
          state = AsyncValue.data(appointments);
        },
        failure: (error) {
          state = AsyncValue.error(error, StackTrace.current);
        },
      );
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> cancelAppointment(String appointmentId) async {
    try {
      final result = await _repository.cancelAppointment(
        appointmentId: appointmentId,
      );

      result.when(
        success: (_) {
          // Reload appointments after cancellation
          loadAppointments();
        },
        failure: (error) {
          state = AsyncValue.error(error, StackTrace.current);
        },
      );
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> createAppointment({
    required String businessId,
    required String serviceId,
    String? employeeId,
    required DateTime appointmentDate,
    required String timeSlot,
    String? notes,
  }) async {
    try {
      final result = await _repository.createAppointment(
        businessId: businessId,
        userId: userId,
        serviceId: serviceId,
        employeeId: employeeId,
        appointmentDate: appointmentDate,
        timeSlot: timeSlot,
        notes: notes,
      );

      result.when(
        success: (_) {
          // Reload appointments after creation
          loadAppointments();
        },
        failure: (error) {
          state = AsyncValue.error(error, StackTrace.current);
        },
      );
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

// Repository provider
final appointmentRepositoryProvider = Provider<IAppointmentRepository>((ref) {
  final cacheManager = ref.watch(cacheManagerProvider);
  return AppointmentRepositoryFactory.create(cacheManager: cacheManager);
});

// Provider factory - requires userId
final appointmentsProvider = StateNotifierProvider.family<AppointmentsNotifier,
    AsyncValue<List<AppointmentModel>>, String>((ref, userId) {
  final repository = ref.watch(appointmentRepositoryProvider);
  return AppointmentsNotifier(repository, userId);
});

// Default provider for current user (using mock user1)
final currentUserAppointmentsProvider = StateNotifierProvider<
    AppointmentsNotifier, AsyncValue<List<AppointmentModel>>>(
  (ref) {
    final repository = ref.watch(appointmentRepositoryProvider);
    return AppointmentsNotifier(repository, 'user1');
  },
);

// Filter providers
final upcomingAppointmentsProvider = Provider<List<AppointmentModel>>((ref) {
  final appointmentsAsync = ref.watch(currentUserAppointmentsProvider);
  return appointmentsAsync.when(
    data: (appointments) {
      final now = DateTime.now();
      return appointments
          .where((apt) =>
              apt.dateTime.isAfter(now) &&
              (apt.status == AppointmentStatus.confirmed ||
                  apt.status == AppointmentStatus.pending))
          .toList()
        ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
    },
    loading: () => [],
    error: (_, __) => [],
  );
});

final pastAppointmentsProvider = Provider<List<AppointmentModel>>((ref) {
  final appointmentsAsync = ref.watch(currentUserAppointmentsProvider);
  return appointmentsAsync.when(
    data: (appointments) {
      final now = DateTime.now();
      return appointments
          .where((apt) =>
              apt.dateTime.isBefore(now) ||
              apt.status == AppointmentStatus.completed ||
              apt.status == AppointmentStatus.cancelled ||
              apt.status == AppointmentStatus.noShow)
          .toList()
        ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
    },
    loading: () => [],
    error: (_, __) => [],
  );
});
