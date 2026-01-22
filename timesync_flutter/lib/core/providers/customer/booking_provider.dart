import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/service_model.dart';
import '../../repositories/appointment_repository_factory.dart';
import '../../repositories/service_repository_factory.dart';
import '../storage_providers.dart';

class BookingState {
  final String? businessId;
  final String? businessName;
  final List<ServiceModel> selectedServices;
  final String? selectedEmployeeId;
  final String? selectedEmployeeName;
  final DateTime? selectedDate;
  final String? selectedTime;

  const BookingState({
    this.businessId,
    this.businessName,
    this.selectedServices = const [],
    this.selectedEmployeeId,
    this.selectedEmployeeName,
    this.selectedDate,
    this.selectedTime,
  });

  BookingState copyWith({
    String? businessId,
    String? businessName,
    List<ServiceModel>? selectedServices,
    String? selectedEmployeeId,
    String? selectedEmployeeName,
    DateTime? selectedDate,
    String? selectedTime,
  }) {
    return BookingState(
      businessId: businessId ?? this.businessId,
      businessName: businessName ?? this.businessName,
      selectedServices: selectedServices ?? this.selectedServices,
      selectedEmployeeId: selectedEmployeeId ?? this.selectedEmployeeId,
      selectedEmployeeName: selectedEmployeeName ?? this.selectedEmployeeName,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
    );
  }

  double get totalPrice {
    return selectedServices.fold(0.0, (sum, service) => sum + service.price);
  }

  int get totalDuration {
    return selectedServices.fold(0, (sum, service) => sum + service.duration);
  }

  bool get isValid {
    return businessId != null &&
        selectedServices.isNotEmpty &&
        selectedEmployeeId != null &&
        selectedDate != null &&
        selectedTime != null;
  }
}

class BookingNotifier extends StateNotifier<BookingState> {
  final IAppointmentRepository _appointmentRepository;
  final IServiceRepository _serviceRepository;

  BookingNotifier(this._appointmentRepository, this._serviceRepository)
      : super(const BookingState());

  void initBooking(String businessId, String businessName) {
    state = BookingState(
      businessId: businessId,
      businessName: businessName,
    );
  }

  void toggleService(ServiceModel service) {
    final services = List<ServiceModel>.from(state.selectedServices);

    if (services.any((s) => s.id == service.id)) {
      services.removeWhere((s) => s.id == service.id);
    } else {
      services.add(service);
    }

    state = state.copyWith(selectedServices: services);
  }

  void selectEmployee(String employeeId, String employeeName) {
    state = state.copyWith(
      selectedEmployeeId: employeeId,
      selectedEmployeeName: employeeName,
    );
  }

  void selectDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
  }

  void selectTime(String time) {
    state = state.copyWith(selectedTime: time);
  }

  void reset() {
    state = const BookingState();
  }

  Future<bool> confirmBooking() async {
    if (!state.isValid) return false;

    try {
      // Combine selected date and time
      final dateTime = DateTime(
        state.selectedDate!.year,
        state.selectedDate!.month,
        state.selectedDate!.day,
        int.parse(state.selectedTime!.split(':')[0]),
        int.parse(state.selectedTime!.split(':')[1]),
      );

      // Create appointment through repository
      final result = await _appointmentRepository.createAppointment(
        businessId: state.businessId!,
        serviceId: state.selectedServices.first.id,
        userId: 'user1', // TODO: Get current user ID
        employeeId: state.selectedEmployeeId,
        appointmentDate: dateTime,
        timeSlot: state.selectedTime!,
      );

      return result.when(
        success: (_) {
          reset();
          return true;
        },
        failure: (_) => false,
      );
    } catch (e) {
      return false;
    }
  }
}

// Repository providers
final serviceRepositoryProvider = Provider<IServiceRepository>((ref) {
  final cacheManager = ref.watch(cacheManagerProvider);
  return ServiceRepositoryFactory.create(cacheManager: cacheManager);
});

// We can reuse appointmentRepositoryProvider from appointments_provider.dart
// But for simplicity and to avoid circular imports if any, we can define it here or in a common place.
// Let's assume lib/core/providers/customer/appointments_provider.dart is safe to import.
final appointmentRepositoryProvider = Provider<IAppointmentRepository>((ref) {
  final cacheManager = ref.watch(cacheManagerProvider);
  return AppointmentRepositoryFactory.create(cacheManager: cacheManager);
});

final bookingProvider = StateNotifierProvider<BookingNotifier, BookingState>(
  (ref) {
    final appointmentRepo = ref.watch(appointmentRepositoryProvider);
    final serviceRepo = ref.watch(serviceRepositoryProvider);
    return BookingNotifier(appointmentRepo, serviceRepo);
  },
);
