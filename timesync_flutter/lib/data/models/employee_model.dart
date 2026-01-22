import 'package:freezed_annotation/freezed_annotation.dart';

part 'employee_model.freezed.dart';
part 'employee_model.g.dart';

@freezed
class EmployeeModel with _$EmployeeModel {
  const factory EmployeeModel({
    required String id,
    required String businessId,
    required String userId,
    required String name,
    required String role,
    required String phone,
    required String email,
    String? photoUrl,
    required double rating,
    required int totalAppointments,
    required double totalRevenue,
    required bool isActive,
    String? workingHours,
    List<String>? specialties,
    DateTime? createdAt,
  }) = _EmployeeModel;

  factory EmployeeModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeModelFromJson(json);
}
