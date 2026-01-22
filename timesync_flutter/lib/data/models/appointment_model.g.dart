// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppointmentModelImpl _$$AppointmentModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AppointmentModelImpl(
      id: json['id'] as String,
      businessId: json['businessId'] as String,
      businessName: json['businessName'] as String,
      customerId: json['customerId'] as String,
      customerName: json['customerName'] as String,
      employeeId: json['employeeId'] as String,
      employeeName: json['employeeName'] as String,
      serviceIds: (json['serviceIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      serviceNames: (json['serviceNames'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      dateTime: DateTime.parse(json['dateTime'] as String),
      duration: (json['duration'] as num).toInt(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
      status: $enumDecode(_$AppointmentStatusEnumMap, json['status']),
      notes: json['notes'] as String?,
      cancelReason: json['cancelReason'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$AppointmentModelImplToJson(
        _$AppointmentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'businessId': instance.businessId,
      'businessName': instance.businessName,
      'customerId': instance.customerId,
      'customerName': instance.customerName,
      'employeeId': instance.employeeId,
      'employeeName': instance.employeeName,
      'serviceIds': instance.serviceIds,
      'serviceNames': instance.serviceNames,
      'dateTime': instance.dateTime.toIso8601String(),
      'duration': instance.duration,
      'totalPrice': instance.totalPrice,
      'status': _$AppointmentStatusEnumMap[instance.status]!,
      'notes': instance.notes,
      'cancelReason': instance.cancelReason,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$AppointmentStatusEnumMap = {
  AppointmentStatus.pending: 'pending',
  AppointmentStatus.confirmed: 'confirmed',
  AppointmentStatus.completed: 'completed',
  AppointmentStatus.cancelled: 'cancelled',
  AppointmentStatus.noShow: 'noShow',
};
