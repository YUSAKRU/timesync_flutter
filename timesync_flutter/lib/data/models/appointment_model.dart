import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment_model.freezed.dart';
part 'appointment_model.g.dart';

@freezed
class AppointmentModel with _$AppointmentModel {
  const factory AppointmentModel({
    required String id,
    required String businessId,
    required String businessName,
    required String customerId,
    required String customerName,
    required String employeeId,
    required String employeeName,
    required List<String> serviceIds,
    required List<String> serviceNames,
    required DateTime dateTime,
    required int duration,
    required double totalPrice,
    required AppointmentStatus status,
    String? notes,
    String? cancelReason,
    DateTime? createdAt,
  }) = _AppointmentModel;

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentModelFromJson(json);
}

enum AppointmentStatus {
  pending,
  confirmed,
  completed,
  cancelled,
  noShow,
}
