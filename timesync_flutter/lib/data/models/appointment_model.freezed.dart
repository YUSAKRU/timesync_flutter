// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppointmentModel _$AppointmentModelFromJson(Map<String, dynamic> json) {
  return _AppointmentModel.fromJson(json);
}

/// @nodoc
mixin _$AppointmentModel {
  String get id => throw _privateConstructorUsedError;
  String get businessId => throw _privateConstructorUsedError;
  String get businessName => throw _privateConstructorUsedError;
  String get customerId => throw _privateConstructorUsedError;
  String get customerName => throw _privateConstructorUsedError;
  String get employeeId => throw _privateConstructorUsedError;
  String get employeeName => throw _privateConstructorUsedError;
  List<String> get serviceIds => throw _privateConstructorUsedError;
  List<String> get serviceNames => throw _privateConstructorUsedError;
  DateTime get dateTime => throw _privateConstructorUsedError;
  int get duration => throw _privateConstructorUsedError;
  double get totalPrice => throw _privateConstructorUsedError;
  AppointmentStatus get status => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String? get cancelReason => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppointmentModelCopyWith<AppointmentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentModelCopyWith<$Res> {
  factory $AppointmentModelCopyWith(
          AppointmentModel value, $Res Function(AppointmentModel) then) =
      _$AppointmentModelCopyWithImpl<$Res, AppointmentModel>;
  @useResult
  $Res call(
      {String id,
      String businessId,
      String businessName,
      String customerId,
      String customerName,
      String employeeId,
      String employeeName,
      List<String> serviceIds,
      List<String> serviceNames,
      DateTime dateTime,
      int duration,
      double totalPrice,
      AppointmentStatus status,
      String? notes,
      String? cancelReason,
      DateTime? createdAt});
}

/// @nodoc
class _$AppointmentModelCopyWithImpl<$Res, $Val extends AppointmentModel>
    implements $AppointmentModelCopyWith<$Res> {
  _$AppointmentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? businessId = null,
    Object? businessName = null,
    Object? customerId = null,
    Object? customerName = null,
    Object? employeeId = null,
    Object? employeeName = null,
    Object? serviceIds = null,
    Object? serviceNames = null,
    Object? dateTime = null,
    Object? duration = null,
    Object? totalPrice = null,
    Object? status = null,
    Object? notes = freezed,
    Object? cancelReason = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      businessId: null == businessId
          ? _value.businessId
          : businessId // ignore: cast_nullable_to_non_nullable
              as String,
      businessName: null == businessName
          ? _value.businessName
          : businessName // ignore: cast_nullable_to_non_nullable
              as String,
      customerId: null == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      customerName: null == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String,
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String,
      employeeName: null == employeeName
          ? _value.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String,
      serviceIds: null == serviceIds
          ? _value.serviceIds
          : serviceIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      serviceNames: null == serviceNames
          ? _value.serviceNames
          : serviceNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AppointmentStatus,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      cancelReason: freezed == cancelReason
          ? _value.cancelReason
          : cancelReason // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppointmentModelImplCopyWith<$Res>
    implements $AppointmentModelCopyWith<$Res> {
  factory _$$AppointmentModelImplCopyWith(_$AppointmentModelImpl value,
          $Res Function(_$AppointmentModelImpl) then) =
      __$$AppointmentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String businessId,
      String businessName,
      String customerId,
      String customerName,
      String employeeId,
      String employeeName,
      List<String> serviceIds,
      List<String> serviceNames,
      DateTime dateTime,
      int duration,
      double totalPrice,
      AppointmentStatus status,
      String? notes,
      String? cancelReason,
      DateTime? createdAt});
}

/// @nodoc
class __$$AppointmentModelImplCopyWithImpl<$Res>
    extends _$AppointmentModelCopyWithImpl<$Res, _$AppointmentModelImpl>
    implements _$$AppointmentModelImplCopyWith<$Res> {
  __$$AppointmentModelImplCopyWithImpl(_$AppointmentModelImpl _value,
      $Res Function(_$AppointmentModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? businessId = null,
    Object? businessName = null,
    Object? customerId = null,
    Object? customerName = null,
    Object? employeeId = null,
    Object? employeeName = null,
    Object? serviceIds = null,
    Object? serviceNames = null,
    Object? dateTime = null,
    Object? duration = null,
    Object? totalPrice = null,
    Object? status = null,
    Object? notes = freezed,
    Object? cancelReason = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$AppointmentModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      businessId: null == businessId
          ? _value.businessId
          : businessId // ignore: cast_nullable_to_non_nullable
              as String,
      businessName: null == businessName
          ? _value.businessName
          : businessName // ignore: cast_nullable_to_non_nullable
              as String,
      customerId: null == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      customerName: null == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String,
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String,
      employeeName: null == employeeName
          ? _value.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String,
      serviceIds: null == serviceIds
          ? _value._serviceIds
          : serviceIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      serviceNames: null == serviceNames
          ? _value._serviceNames
          : serviceNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AppointmentStatus,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      cancelReason: freezed == cancelReason
          ? _value.cancelReason
          : cancelReason // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppointmentModelImpl implements _AppointmentModel {
  const _$AppointmentModelImpl(
      {required this.id,
      required this.businessId,
      required this.businessName,
      required this.customerId,
      required this.customerName,
      required this.employeeId,
      required this.employeeName,
      required final List<String> serviceIds,
      required final List<String> serviceNames,
      required this.dateTime,
      required this.duration,
      required this.totalPrice,
      required this.status,
      this.notes,
      this.cancelReason,
      this.createdAt})
      : _serviceIds = serviceIds,
        _serviceNames = serviceNames;

  factory _$AppointmentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppointmentModelImplFromJson(json);

  @override
  final String id;
  @override
  final String businessId;
  @override
  final String businessName;
  @override
  final String customerId;
  @override
  final String customerName;
  @override
  final String employeeId;
  @override
  final String employeeName;
  final List<String> _serviceIds;
  @override
  List<String> get serviceIds {
    if (_serviceIds is EqualUnmodifiableListView) return _serviceIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_serviceIds);
  }

  final List<String> _serviceNames;
  @override
  List<String> get serviceNames {
    if (_serviceNames is EqualUnmodifiableListView) return _serviceNames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_serviceNames);
  }

  @override
  final DateTime dateTime;
  @override
  final int duration;
  @override
  final double totalPrice;
  @override
  final AppointmentStatus status;
  @override
  final String? notes;
  @override
  final String? cancelReason;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'AppointmentModel(id: $id, businessId: $businessId, businessName: $businessName, customerId: $customerId, customerName: $customerName, employeeId: $employeeId, employeeName: $employeeName, serviceIds: $serviceIds, serviceNames: $serviceNames, dateTime: $dateTime, duration: $duration, totalPrice: $totalPrice, status: $status, notes: $notes, cancelReason: $cancelReason, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppointmentModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.businessId, businessId) ||
                other.businessId == businessId) &&
            (identical(other.businessName, businessName) ||
                other.businessName == businessName) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.employeeName, employeeName) ||
                other.employeeName == employeeName) &&
            const DeepCollectionEquality()
                .equals(other._serviceIds, _serviceIds) &&
            const DeepCollectionEquality()
                .equals(other._serviceNames, _serviceNames) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.cancelReason, cancelReason) ||
                other.cancelReason == cancelReason) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      businessId,
      businessName,
      customerId,
      customerName,
      employeeId,
      employeeName,
      const DeepCollectionEquality().hash(_serviceIds),
      const DeepCollectionEquality().hash(_serviceNames),
      dateTime,
      duration,
      totalPrice,
      status,
      notes,
      cancelReason,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppointmentModelImplCopyWith<_$AppointmentModelImpl> get copyWith =>
      __$$AppointmentModelImplCopyWithImpl<_$AppointmentModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppointmentModelImplToJson(
      this,
    );
  }
}

abstract class _AppointmentModel implements AppointmentModel {
  const factory _AppointmentModel(
      {required final String id,
      required final String businessId,
      required final String businessName,
      required final String customerId,
      required final String customerName,
      required final String employeeId,
      required final String employeeName,
      required final List<String> serviceIds,
      required final List<String> serviceNames,
      required final DateTime dateTime,
      required final int duration,
      required final double totalPrice,
      required final AppointmentStatus status,
      final String? notes,
      final String? cancelReason,
      final DateTime? createdAt}) = _$AppointmentModelImpl;

  factory _AppointmentModel.fromJson(Map<String, dynamic> json) =
      _$AppointmentModelImpl.fromJson;

  @override
  String get id;
  @override
  String get businessId;
  @override
  String get businessName;
  @override
  String get customerId;
  @override
  String get customerName;
  @override
  String get employeeId;
  @override
  String get employeeName;
  @override
  List<String> get serviceIds;
  @override
  List<String> get serviceNames;
  @override
  DateTime get dateTime;
  @override
  int get duration;
  @override
  double get totalPrice;
  @override
  AppointmentStatus get status;
  @override
  String? get notes;
  @override
  String? get cancelReason;
  @override
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$AppointmentModelImplCopyWith<_$AppointmentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
