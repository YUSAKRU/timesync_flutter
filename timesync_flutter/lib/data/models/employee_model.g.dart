// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployeeModelImpl _$$EmployeeModelImplFromJson(Map<String, dynamic> json) =>
    _$EmployeeModelImpl(
      id: json['id'] as String,
      businessId: json['businessId'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String?,
      rating: (json['rating'] as num).toDouble(),
      totalAppointments: (json['totalAppointments'] as num).toInt(),
      totalRevenue: (json['totalRevenue'] as num).toDouble(),
      isActive: json['isActive'] as bool,
      workingHours: json['workingHours'] as String?,
      specialties: (json['specialties'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$EmployeeModelImplToJson(_$EmployeeModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'businessId': instance.businessId,
      'userId': instance.userId,
      'name': instance.name,
      'role': instance.role,
      'phone': instance.phone,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'rating': instance.rating,
      'totalAppointments': instance.totalAppointments,
      'totalRevenue': instance.totalRevenue,
      'isActive': instance.isActive,
      'workingHours': instance.workingHours,
      'specialties': instance.specialties,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
