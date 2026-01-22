import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/appointment_model.dart';

class EmployeeScheduleNotifier
    extends StateNotifier<AsyncValue<List<AppointmentModel>>> {
  EmployeeScheduleNotifier() : super(const AsyncValue.loading()) {
    loadSchedule();
  }

  Future<void> loadSchedule({DateTime? date}) async {
    state = const AsyncValue.loading();

    try {
      await Future.delayed(const Duration(milliseconds: 800));

      final appointments = _generateMockSchedule(date ?? DateTime.now());
      state = AsyncValue.data(appointments);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateAppointmentStatus(
    String appointmentId,
    AppointmentStatus status,
  ) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      state.whenData((appointments) {
        final updatedAppointments = appointments.map((apt) {
          if (apt.id == appointmentId) {
            return apt.copyWith(status: status);
          }
          return apt;
        }).toList();

        state = AsyncValue.data(updatedAppointments);
      });
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  List<AppointmentModel> _generateMockSchedule(DateTime selectedDate) {
    final now = DateTime.now();

    return [
      AppointmentModel(
        id: '1',
        businessId: '1',
        businessName: 'Makas Sanat',
        customerId: 'c1',
        customerName: 'Ahmet Yılmaz',
        employeeId: 'emp1',
        employeeName: 'Mehmet Demir',
        serviceIds: ['s1'],
        serviceNames: ['Saç Kesimi'],
        dateTime: DateTime(now.year, now.month, now.day, 10, 0),
        duration: 45,
        totalPrice: 150,
        status: AppointmentStatus.completed,
        createdAt: now.subtract(const Duration(days: 2)),
      ),
      AppointmentModel(
        id: '2',
        businessId: '1',
        businessName: 'Makas Sanat',
        customerId: 'c2',
        customerName: 'Mehmet Kaya',
        employeeId: 'emp1',
        employeeName: 'Mehmet Demir',
        serviceIds: ['s1', 's2'],
        serviceNames: ['Saç Kesimi', 'Sakal Tıraşı'],
        dateTime: DateTime(now.year, now.month, now.day, 11, 30),
        duration: 60,
        totalPrice: 230,
        status: AppointmentStatus.confirmed,
        createdAt: now.subtract(const Duration(days: 1)),
      ),
      AppointmentModel(
        id: '3',
        businessId: '1',
        businessName: 'Makas Sanat',
        customerId: 'c3',
        customerName: 'Ali Demir',
        employeeId: 'emp1',
        employeeName: 'Mehmet Demir',
        serviceIds: ['s3'],
        serviceNames: ['Cilt Bakımı'],
        dateTime: DateTime(now.year, now.month, now.day, 14, 0),
        duration: 45,
        totalPrice: 180,
        status: AppointmentStatus.pending,
        createdAt: now,
      ),
      AppointmentModel(
        id: '4',
        businessId: '1',
        businessName: 'Makas Sanat',
        customerId: 'c4',
        customerName: 'Zeynep Şahin',
        employeeId: 'emp1',
        employeeName: 'Mehmet Demir',
        serviceIds: ['s1'],
        serviceNames: ['Saç Kesimi'],
        dateTime: DateTime(now.year, now.month, now.day, 16, 30),
        duration: 45,
        totalPrice: 150,
        status: AppointmentStatus.confirmed,
        createdAt: now,
      ),
    ];
  }
}

final employeeScheduleProvider = StateNotifierProvider<
    EmployeeScheduleNotifier, AsyncValue<List<AppointmentModel>>>(
  (ref) => EmployeeScheduleNotifier(),
);

// Today's appointments provider
final todayAppointmentsProvider = Provider<List<AppointmentModel>>((ref) {
  final scheduleAsync = ref.watch(employeeScheduleProvider);
  return scheduleAsync.when(
    data: (appointments) {
      final now = DateTime.now();
      return appointments
          .where((apt) =>
              apt.dateTime.year == now.year &&
              apt.dateTime.month == now.month &&
              apt.dateTime.day == now.day)
          .toList()
        ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
    },
    loading: () => [],
    error: (_, __) => [],
  );
});
