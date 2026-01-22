// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) {
  return _ReviewModel.fromJson(json);
}

/// @nodoc
mixin _$ReviewModel {
  String get id => throw _privateConstructorUsedError;
  String get businessId => throw _privateConstructorUsedError;
  String get customerId => throw _privateConstructorUsedError;
  String get customerName => throw _privateConstructorUsedError;
  String? get customerPhotoUrl => throw _privateConstructorUsedError;
  String get appointmentId => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError; // 1.0 - 5.0
  String get title => throw _privateConstructorUsedError;
  String get comment => throw _privateConstructorUsedError;
  List<String>? get images => throw _privateConstructorUsedError;
  bool get isVerified =>
      throw _privateConstructorUsedError; // Purchase verified
  bool get isPublished =>
      throw _privateConstructorUsedError; // Business Response
  String? get businessResponse => throw _privateConstructorUsedError;
  DateTime? get businessResponseDate => throw _privateConstructorUsedError;
  String? get businessResponderId =>
      throw _privateConstructorUsedError; // Metadata
  int? get helpfulCount => throw _privateConstructorUsedError;
  int? get unhelpfulCount => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;
  bool? get isReported => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReviewModelCopyWith<ReviewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewModelCopyWith<$Res> {
  factory $ReviewModelCopyWith(
          ReviewModel value, $Res Function(ReviewModel) then) =
      _$ReviewModelCopyWithImpl<$Res, ReviewModel>;
  @useResult
  $Res call(
      {String id,
      String businessId,
      String customerId,
      String customerName,
      String? customerPhotoUrl,
      String appointmentId,
      double rating,
      String title,
      String comment,
      List<String>? images,
      bool isVerified,
      bool isPublished,
      String? businessResponse,
      DateTime? businessResponseDate,
      String? businessResponderId,
      int? helpfulCount,
      int? unhelpfulCount,
      List<String>? tags,
      bool? isReported,
      DateTime createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$ReviewModelCopyWithImpl<$Res, $Val extends ReviewModel>
    implements $ReviewModelCopyWith<$Res> {
  _$ReviewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? businessId = null,
    Object? customerId = null,
    Object? customerName = null,
    Object? customerPhotoUrl = freezed,
    Object? appointmentId = null,
    Object? rating = null,
    Object? title = null,
    Object? comment = null,
    Object? images = freezed,
    Object? isVerified = null,
    Object? isPublished = null,
    Object? businessResponse = freezed,
    Object? businessResponseDate = freezed,
    Object? businessResponderId = freezed,
    Object? helpfulCount = freezed,
    Object? unhelpfulCount = freezed,
    Object? tags = freezed,
    Object? isReported = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
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
      customerId: null == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      customerName: null == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String,
      customerPhotoUrl: freezed == customerPhotoUrl
          ? _value.customerPhotoUrl
          : customerPhotoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      images: freezed == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      isPublished: null == isPublished
          ? _value.isPublished
          : isPublished // ignore: cast_nullable_to_non_nullable
              as bool,
      businessResponse: freezed == businessResponse
          ? _value.businessResponse
          : businessResponse // ignore: cast_nullable_to_non_nullable
              as String?,
      businessResponseDate: freezed == businessResponseDate
          ? _value.businessResponseDate
          : businessResponseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      businessResponderId: freezed == businessResponderId
          ? _value.businessResponderId
          : businessResponderId // ignore: cast_nullable_to_non_nullable
              as String?,
      helpfulCount: freezed == helpfulCount
          ? _value.helpfulCount
          : helpfulCount // ignore: cast_nullable_to_non_nullable
              as int?,
      unhelpfulCount: freezed == unhelpfulCount
          ? _value.unhelpfulCount
          : unhelpfulCount // ignore: cast_nullable_to_non_nullable
              as int?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isReported: freezed == isReported
          ? _value.isReported
          : isReported // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReviewModelImplCopyWith<$Res>
    implements $ReviewModelCopyWith<$Res> {
  factory _$$ReviewModelImplCopyWith(
          _$ReviewModelImpl value, $Res Function(_$ReviewModelImpl) then) =
      __$$ReviewModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String businessId,
      String customerId,
      String customerName,
      String? customerPhotoUrl,
      String appointmentId,
      double rating,
      String title,
      String comment,
      List<String>? images,
      bool isVerified,
      bool isPublished,
      String? businessResponse,
      DateTime? businessResponseDate,
      String? businessResponderId,
      int? helpfulCount,
      int? unhelpfulCount,
      List<String>? tags,
      bool? isReported,
      DateTime createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$ReviewModelImplCopyWithImpl<$Res>
    extends _$ReviewModelCopyWithImpl<$Res, _$ReviewModelImpl>
    implements _$$ReviewModelImplCopyWith<$Res> {
  __$$ReviewModelImplCopyWithImpl(
      _$ReviewModelImpl _value, $Res Function(_$ReviewModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? businessId = null,
    Object? customerId = null,
    Object? customerName = null,
    Object? customerPhotoUrl = freezed,
    Object? appointmentId = null,
    Object? rating = null,
    Object? title = null,
    Object? comment = null,
    Object? images = freezed,
    Object? isVerified = null,
    Object? isPublished = null,
    Object? businessResponse = freezed,
    Object? businessResponseDate = freezed,
    Object? businessResponderId = freezed,
    Object? helpfulCount = freezed,
    Object? unhelpfulCount = freezed,
    Object? tags = freezed,
    Object? isReported = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$ReviewModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      businessId: null == businessId
          ? _value.businessId
          : businessId // ignore: cast_nullable_to_non_nullable
              as String,
      customerId: null == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      customerName: null == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String,
      customerPhotoUrl: freezed == customerPhotoUrl
          ? _value.customerPhotoUrl
          : customerPhotoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      images: freezed == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      isPublished: null == isPublished
          ? _value.isPublished
          : isPublished // ignore: cast_nullable_to_non_nullable
              as bool,
      businessResponse: freezed == businessResponse
          ? _value.businessResponse
          : businessResponse // ignore: cast_nullable_to_non_nullable
              as String?,
      businessResponseDate: freezed == businessResponseDate
          ? _value.businessResponseDate
          : businessResponseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      businessResponderId: freezed == businessResponderId
          ? _value.businessResponderId
          : businessResponderId // ignore: cast_nullable_to_non_nullable
              as String?,
      helpfulCount: freezed == helpfulCount
          ? _value.helpfulCount
          : helpfulCount // ignore: cast_nullable_to_non_nullable
              as int?,
      unhelpfulCount: freezed == unhelpfulCount
          ? _value.unhelpfulCount
          : unhelpfulCount // ignore: cast_nullable_to_non_nullable
              as int?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isReported: freezed == isReported
          ? _value.isReported
          : isReported // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReviewModelImpl implements _ReviewModel {
  const _$ReviewModelImpl(
      {required this.id,
      required this.businessId,
      required this.customerId,
      required this.customerName,
      this.customerPhotoUrl,
      required this.appointmentId,
      required this.rating,
      required this.title,
      required this.comment,
      final List<String>? images,
      required this.isVerified,
      required this.isPublished,
      this.businessResponse,
      this.businessResponseDate,
      this.businessResponderId,
      this.helpfulCount,
      this.unhelpfulCount,
      final List<String>? tags,
      this.isReported,
      required this.createdAt,
      this.updatedAt})
      : _images = images,
        _tags = tags;

  factory _$ReviewModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewModelImplFromJson(json);

  @override
  final String id;
  @override
  final String businessId;
  @override
  final String customerId;
  @override
  final String customerName;
  @override
  final String? customerPhotoUrl;
  @override
  final String appointmentId;
  @override
  final double rating;
// 1.0 - 5.0
  @override
  final String title;
  @override
  final String comment;
  final List<String>? _images;
  @override
  List<String>? get images {
    final value = _images;
    if (value == null) return null;
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool isVerified;
// Purchase verified
  @override
  final bool isPublished;
// Business Response
  @override
  final String? businessResponse;
  @override
  final DateTime? businessResponseDate;
  @override
  final String? businessResponderId;
// Metadata
  @override
  final int? helpfulCount;
  @override
  final int? unhelpfulCount;
  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? isReported;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'ReviewModel(id: $id, businessId: $businessId, customerId: $customerId, customerName: $customerName, customerPhotoUrl: $customerPhotoUrl, appointmentId: $appointmentId, rating: $rating, title: $title, comment: $comment, images: $images, isVerified: $isVerified, isPublished: $isPublished, businessResponse: $businessResponse, businessResponseDate: $businessResponseDate, businessResponderId: $businessResponderId, helpfulCount: $helpfulCount, unhelpfulCount: $unhelpfulCount, tags: $tags, isReported: $isReported, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.businessId, businessId) ||
                other.businessId == businessId) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.customerPhotoUrl, customerPhotoUrl) ||
                other.customerPhotoUrl == customerPhotoUrl) &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.isPublished, isPublished) ||
                other.isPublished == isPublished) &&
            (identical(other.businessResponse, businessResponse) ||
                other.businessResponse == businessResponse) &&
            (identical(other.businessResponseDate, businessResponseDate) ||
                other.businessResponseDate == businessResponseDate) &&
            (identical(other.businessResponderId, businessResponderId) ||
                other.businessResponderId == businessResponderId) &&
            (identical(other.helpfulCount, helpfulCount) ||
                other.helpfulCount == helpfulCount) &&
            (identical(other.unhelpfulCount, unhelpfulCount) ||
                other.unhelpfulCount == unhelpfulCount) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.isReported, isReported) ||
                other.isReported == isReported) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        businessId,
        customerId,
        customerName,
        customerPhotoUrl,
        appointmentId,
        rating,
        title,
        comment,
        const DeepCollectionEquality().hash(_images),
        isVerified,
        isPublished,
        businessResponse,
        businessResponseDate,
        businessResponderId,
        helpfulCount,
        unhelpfulCount,
        const DeepCollectionEquality().hash(_tags),
        isReported,
        createdAt,
        updatedAt
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewModelImplCopyWith<_$ReviewModelImpl> get copyWith =>
      __$$ReviewModelImplCopyWithImpl<_$ReviewModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReviewModelImplToJson(
      this,
    );
  }
}

abstract class _ReviewModel implements ReviewModel {
  const factory _ReviewModel(
      {required final String id,
      required final String businessId,
      required final String customerId,
      required final String customerName,
      final String? customerPhotoUrl,
      required final String appointmentId,
      required final double rating,
      required final String title,
      required final String comment,
      final List<String>? images,
      required final bool isVerified,
      required final bool isPublished,
      final String? businessResponse,
      final DateTime? businessResponseDate,
      final String? businessResponderId,
      final int? helpfulCount,
      final int? unhelpfulCount,
      final List<String>? tags,
      final bool? isReported,
      required final DateTime createdAt,
      final DateTime? updatedAt}) = _$ReviewModelImpl;

  factory _ReviewModel.fromJson(Map<String, dynamic> json) =
      _$ReviewModelImpl.fromJson;

  @override
  String get id;
  @override
  String get businessId;
  @override
  String get customerId;
  @override
  String get customerName;
  @override
  String? get customerPhotoUrl;
  @override
  String get appointmentId;
  @override
  double get rating;
  @override // 1.0 - 5.0
  String get title;
  @override
  String get comment;
  @override
  List<String>? get images;
  @override
  bool get isVerified;
  @override // Purchase verified
  bool get isPublished;
  @override // Business Response
  String? get businessResponse;
  @override
  DateTime? get businessResponseDate;
  @override
  String? get businessResponderId;
  @override // Metadata
  int? get helpfulCount;
  @override
  int? get unhelpfulCount;
  @override
  List<String>? get tags;
  @override
  bool? get isReported;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$ReviewModelImplCopyWith<_$ReviewModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateReviewRequest _$CreateReviewRequestFromJson(Map<String, dynamic> json) {
  return _CreateReviewRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateReviewRequest {
  String get appointmentId => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get comment => throw _privateConstructorUsedError;
  List<String>? get images => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreateReviewRequestCopyWith<CreateReviewRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateReviewRequestCopyWith<$Res> {
  factory $CreateReviewRequestCopyWith(
          CreateReviewRequest value, $Res Function(CreateReviewRequest) then) =
      _$CreateReviewRequestCopyWithImpl<$Res, CreateReviewRequest>;
  @useResult
  $Res call(
      {String appointmentId,
      double rating,
      String title,
      String comment,
      List<String>? images,
      List<String>? tags});
}

/// @nodoc
class _$CreateReviewRequestCopyWithImpl<$Res, $Val extends CreateReviewRequest>
    implements $CreateReviewRequestCopyWith<$Res> {
  _$CreateReviewRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointmentId = null,
    Object? rating = null,
    Object? title = null,
    Object? comment = null,
    Object? images = freezed,
    Object? tags = freezed,
  }) {
    return _then(_value.copyWith(
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      images: freezed == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateReviewRequestImplCopyWith<$Res>
    implements $CreateReviewRequestCopyWith<$Res> {
  factory _$$CreateReviewRequestImplCopyWith(_$CreateReviewRequestImpl value,
          $Res Function(_$CreateReviewRequestImpl) then) =
      __$$CreateReviewRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String appointmentId,
      double rating,
      String title,
      String comment,
      List<String>? images,
      List<String>? tags});
}

/// @nodoc
class __$$CreateReviewRequestImplCopyWithImpl<$Res>
    extends _$CreateReviewRequestCopyWithImpl<$Res, _$CreateReviewRequestImpl>
    implements _$$CreateReviewRequestImplCopyWith<$Res> {
  __$$CreateReviewRequestImplCopyWithImpl(_$CreateReviewRequestImpl _value,
      $Res Function(_$CreateReviewRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appointmentId = null,
    Object? rating = null,
    Object? title = null,
    Object? comment = null,
    Object? images = freezed,
    Object? tags = freezed,
  }) {
    return _then(_$CreateReviewRequestImpl(
      appointmentId: null == appointmentId
          ? _value.appointmentId
          : appointmentId // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      images: freezed == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateReviewRequestImpl implements _CreateReviewRequest {
  const _$CreateReviewRequestImpl(
      {required this.appointmentId,
      required this.rating,
      required this.title,
      required this.comment,
      final List<String>? images,
      final List<String>? tags})
      : _images = images,
        _tags = tags;

  factory _$CreateReviewRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateReviewRequestImplFromJson(json);

  @override
  final String appointmentId;
  @override
  final double rating;
  @override
  final String title;
  @override
  final String comment;
  final List<String>? _images;
  @override
  List<String>? get images {
    final value = _images;
    if (value == null) return null;
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'CreateReviewRequest(appointmentId: $appointmentId, rating: $rating, title: $title, comment: $comment, images: $images, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateReviewRequestImpl &&
            (identical(other.appointmentId, appointmentId) ||
                other.appointmentId == appointmentId) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      appointmentId,
      rating,
      title,
      comment,
      const DeepCollectionEquality().hash(_images),
      const DeepCollectionEquality().hash(_tags));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateReviewRequestImplCopyWith<_$CreateReviewRequestImpl> get copyWith =>
      __$$CreateReviewRequestImplCopyWithImpl<_$CreateReviewRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateReviewRequestImplToJson(
      this,
    );
  }
}

abstract class _CreateReviewRequest implements CreateReviewRequest {
  const factory _CreateReviewRequest(
      {required final String appointmentId,
      required final double rating,
      required final String title,
      required final String comment,
      final List<String>? images,
      final List<String>? tags}) = _$CreateReviewRequestImpl;

  factory _CreateReviewRequest.fromJson(Map<String, dynamic> json) =
      _$CreateReviewRequestImpl.fromJson;

  @override
  String get appointmentId;
  @override
  double get rating;
  @override
  String get title;
  @override
  String get comment;
  @override
  List<String>? get images;
  @override
  List<String>? get tags;
  @override
  @JsonKey(ignore: true)
  _$$CreateReviewRequestImplCopyWith<_$CreateReviewRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BusinessResponseRequest _$BusinessResponseRequestFromJson(
    Map<String, dynamic> json) {
  return _BusinessResponseRequest.fromJson(json);
}

/// @nodoc
mixin _$BusinessResponseRequest {
  String get responseText => throw _privateConstructorUsedError;
  String? get responderId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BusinessResponseRequestCopyWith<BusinessResponseRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusinessResponseRequestCopyWith<$Res> {
  factory $BusinessResponseRequestCopyWith(BusinessResponseRequest value,
          $Res Function(BusinessResponseRequest) then) =
      _$BusinessResponseRequestCopyWithImpl<$Res, BusinessResponseRequest>;
  @useResult
  $Res call({String responseText, String? responderId});
}

/// @nodoc
class _$BusinessResponseRequestCopyWithImpl<$Res,
        $Val extends BusinessResponseRequest>
    implements $BusinessResponseRequestCopyWith<$Res> {
  _$BusinessResponseRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? responseText = null,
    Object? responderId = freezed,
  }) {
    return _then(_value.copyWith(
      responseText: null == responseText
          ? _value.responseText
          : responseText // ignore: cast_nullable_to_non_nullable
              as String,
      responderId: freezed == responderId
          ? _value.responderId
          : responderId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BusinessResponseRequestImplCopyWith<$Res>
    implements $BusinessResponseRequestCopyWith<$Res> {
  factory _$$BusinessResponseRequestImplCopyWith(
          _$BusinessResponseRequestImpl value,
          $Res Function(_$BusinessResponseRequestImpl) then) =
      __$$BusinessResponseRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String responseText, String? responderId});
}

/// @nodoc
class __$$BusinessResponseRequestImplCopyWithImpl<$Res>
    extends _$BusinessResponseRequestCopyWithImpl<$Res,
        _$BusinessResponseRequestImpl>
    implements _$$BusinessResponseRequestImplCopyWith<$Res> {
  __$$BusinessResponseRequestImplCopyWithImpl(
      _$BusinessResponseRequestImpl _value,
      $Res Function(_$BusinessResponseRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? responseText = null,
    Object? responderId = freezed,
  }) {
    return _then(_$BusinessResponseRequestImpl(
      responseText: null == responseText
          ? _value.responseText
          : responseText // ignore: cast_nullable_to_non_nullable
              as String,
      responderId: freezed == responderId
          ? _value.responderId
          : responderId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BusinessResponseRequestImpl implements _BusinessResponseRequest {
  const _$BusinessResponseRequestImpl(
      {required this.responseText, this.responderId});

  factory _$BusinessResponseRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusinessResponseRequestImplFromJson(json);

  @override
  final String responseText;
  @override
  final String? responderId;

  @override
  String toString() {
    return 'BusinessResponseRequest(responseText: $responseText, responderId: $responderId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusinessResponseRequestImpl &&
            (identical(other.responseText, responseText) ||
                other.responseText == responseText) &&
            (identical(other.responderId, responderId) ||
                other.responderId == responderId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, responseText, responderId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BusinessResponseRequestImplCopyWith<_$BusinessResponseRequestImpl>
      get copyWith => __$$BusinessResponseRequestImplCopyWithImpl<
          _$BusinessResponseRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BusinessResponseRequestImplToJson(
      this,
    );
  }
}

abstract class _BusinessResponseRequest implements BusinessResponseRequest {
  const factory _BusinessResponseRequest(
      {required final String responseText,
      final String? responderId}) = _$BusinessResponseRequestImpl;

  factory _BusinessResponseRequest.fromJson(Map<String, dynamic> json) =
      _$BusinessResponseRequestImpl.fromJson;

  @override
  String get responseText;
  @override
  String? get responderId;
  @override
  @JsonKey(ignore: true)
  _$$BusinessResponseRequestImplCopyWith<_$BusinessResponseRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ReviewsResponse _$ReviewsResponseFromJson(Map<String, dynamic> json) {
  return _ReviewsResponse.fromJson(json);
}

/// @nodoc
mixin _$ReviewsResponse {
  List<ReviewModel> get reviews => throw _privateConstructorUsedError;
  double get averageRating => throw _privateConstructorUsedError;
  Map<String, int> get ratingDistribution =>
      throw _privateConstructorUsedError; // "5": 42, "4": 28, etc
  int get totalReviews => throw _privateConstructorUsedError;
  int get verifiedReviews => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReviewsResponseCopyWith<ReviewsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewsResponseCopyWith<$Res> {
  factory $ReviewsResponseCopyWith(
          ReviewsResponse value, $Res Function(ReviewsResponse) then) =
      _$ReviewsResponseCopyWithImpl<$Res, ReviewsResponse>;
  @useResult
  $Res call(
      {List<ReviewModel> reviews,
      double averageRating,
      Map<String, int> ratingDistribution,
      int totalReviews,
      int verifiedReviews,
      bool hasMore,
      int page});
}

/// @nodoc
class _$ReviewsResponseCopyWithImpl<$Res, $Val extends ReviewsResponse>
    implements $ReviewsResponseCopyWith<$Res> {
  _$ReviewsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reviews = null,
    Object? averageRating = null,
    Object? ratingDistribution = null,
    Object? totalReviews = null,
    Object? verifiedReviews = null,
    Object? hasMore = null,
    Object? page = null,
  }) {
    return _then(_value.copyWith(
      reviews: null == reviews
          ? _value.reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as List<ReviewModel>,
      averageRating: null == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double,
      ratingDistribution: null == ratingDistribution
          ? _value.ratingDistribution
          : ratingDistribution // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      totalReviews: null == totalReviews
          ? _value.totalReviews
          : totalReviews // ignore: cast_nullable_to_non_nullable
              as int,
      verifiedReviews: null == verifiedReviews
          ? _value.verifiedReviews
          : verifiedReviews // ignore: cast_nullable_to_non_nullable
              as int,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReviewsResponseImplCopyWith<$Res>
    implements $ReviewsResponseCopyWith<$Res> {
  factory _$$ReviewsResponseImplCopyWith(_$ReviewsResponseImpl value,
          $Res Function(_$ReviewsResponseImpl) then) =
      __$$ReviewsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ReviewModel> reviews,
      double averageRating,
      Map<String, int> ratingDistribution,
      int totalReviews,
      int verifiedReviews,
      bool hasMore,
      int page});
}

/// @nodoc
class __$$ReviewsResponseImplCopyWithImpl<$Res>
    extends _$ReviewsResponseCopyWithImpl<$Res, _$ReviewsResponseImpl>
    implements _$$ReviewsResponseImplCopyWith<$Res> {
  __$$ReviewsResponseImplCopyWithImpl(
      _$ReviewsResponseImpl _value, $Res Function(_$ReviewsResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reviews = null,
    Object? averageRating = null,
    Object? ratingDistribution = null,
    Object? totalReviews = null,
    Object? verifiedReviews = null,
    Object? hasMore = null,
    Object? page = null,
  }) {
    return _then(_$ReviewsResponseImpl(
      reviews: null == reviews
          ? _value._reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as List<ReviewModel>,
      averageRating: null == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double,
      ratingDistribution: null == ratingDistribution
          ? _value._ratingDistribution
          : ratingDistribution // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      totalReviews: null == totalReviews
          ? _value.totalReviews
          : totalReviews // ignore: cast_nullable_to_non_nullable
              as int,
      verifiedReviews: null == verifiedReviews
          ? _value.verifiedReviews
          : verifiedReviews // ignore: cast_nullable_to_non_nullable
              as int,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReviewsResponseImpl implements _ReviewsResponse {
  const _$ReviewsResponseImpl(
      {required final List<ReviewModel> reviews,
      required this.averageRating,
      required final Map<String, int> ratingDistribution,
      required this.totalReviews,
      required this.verifiedReviews,
      required this.hasMore,
      required this.page})
      : _reviews = reviews,
        _ratingDistribution = ratingDistribution;

  factory _$ReviewsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewsResponseImplFromJson(json);

  final List<ReviewModel> _reviews;
  @override
  List<ReviewModel> get reviews {
    if (_reviews is EqualUnmodifiableListView) return _reviews;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reviews);
  }

  @override
  final double averageRating;
  final Map<String, int> _ratingDistribution;
  @override
  Map<String, int> get ratingDistribution {
    if (_ratingDistribution is EqualUnmodifiableMapView)
      return _ratingDistribution;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_ratingDistribution);
  }

// "5": 42, "4": 28, etc
  @override
  final int totalReviews;
  @override
  final int verifiedReviews;
  @override
  final bool hasMore;
  @override
  final int page;

  @override
  String toString() {
    return 'ReviewsResponse(reviews: $reviews, averageRating: $averageRating, ratingDistribution: $ratingDistribution, totalReviews: $totalReviews, verifiedReviews: $verifiedReviews, hasMore: $hasMore, page: $page)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewsResponseImpl &&
            const DeepCollectionEquality().equals(other._reviews, _reviews) &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating) &&
            const DeepCollectionEquality()
                .equals(other._ratingDistribution, _ratingDistribution) &&
            (identical(other.totalReviews, totalReviews) ||
                other.totalReviews == totalReviews) &&
            (identical(other.verifiedReviews, verifiedReviews) ||
                other.verifiedReviews == verifiedReviews) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.page, page) || other.page == page));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_reviews),
      averageRating,
      const DeepCollectionEquality().hash(_ratingDistribution),
      totalReviews,
      verifiedReviews,
      hasMore,
      page);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewsResponseImplCopyWith<_$ReviewsResponseImpl> get copyWith =>
      __$$ReviewsResponseImplCopyWithImpl<_$ReviewsResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReviewsResponseImplToJson(
      this,
    );
  }
}

abstract class _ReviewsResponse implements ReviewsResponse {
  const factory _ReviewsResponse(
      {required final List<ReviewModel> reviews,
      required final double averageRating,
      required final Map<String, int> ratingDistribution,
      required final int totalReviews,
      required final int verifiedReviews,
      required final bool hasMore,
      required final int page}) = _$ReviewsResponseImpl;

  factory _ReviewsResponse.fromJson(Map<String, dynamic> json) =
      _$ReviewsResponseImpl.fromJson;

  @override
  List<ReviewModel> get reviews;
  @override
  double get averageRating;
  @override
  Map<String, int> get ratingDistribution;
  @override // "5": 42, "4": 28, etc
  int get totalReviews;
  @override
  int get verifiedReviews;
  @override
  bool get hasMore;
  @override
  int get page;
  @override
  @JsonKey(ignore: true)
  _$$ReviewsResponseImplCopyWith<_$ReviewsResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReviewStats _$ReviewStatsFromJson(Map<String, dynamic> json) {
  return _ReviewStats.fromJson(json);
}

/// @nodoc
mixin _$ReviewStats {
  double get averageRating => throw _privateConstructorUsedError;
  int get totalReviews => throw _privateConstructorUsedError;
  int get verifiedReviews => throw _privateConstructorUsedError;
  Map<String, int> get ratingDistribution => throw _privateConstructorUsedError;
  double get percentageRecommend => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReviewStatsCopyWith<ReviewStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewStatsCopyWith<$Res> {
  factory $ReviewStatsCopyWith(
          ReviewStats value, $Res Function(ReviewStats) then) =
      _$ReviewStatsCopyWithImpl<$Res, ReviewStats>;
  @useResult
  $Res call(
      {double averageRating,
      int totalReviews,
      int verifiedReviews,
      Map<String, int> ratingDistribution,
      double percentageRecommend});
}

/// @nodoc
class _$ReviewStatsCopyWithImpl<$Res, $Val extends ReviewStats>
    implements $ReviewStatsCopyWith<$Res> {
  _$ReviewStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? averageRating = null,
    Object? totalReviews = null,
    Object? verifiedReviews = null,
    Object? ratingDistribution = null,
    Object? percentageRecommend = null,
  }) {
    return _then(_value.copyWith(
      averageRating: null == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double,
      totalReviews: null == totalReviews
          ? _value.totalReviews
          : totalReviews // ignore: cast_nullable_to_non_nullable
              as int,
      verifiedReviews: null == verifiedReviews
          ? _value.verifiedReviews
          : verifiedReviews // ignore: cast_nullable_to_non_nullable
              as int,
      ratingDistribution: null == ratingDistribution
          ? _value.ratingDistribution
          : ratingDistribution // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      percentageRecommend: null == percentageRecommend
          ? _value.percentageRecommend
          : percentageRecommend // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReviewStatsImplCopyWith<$Res>
    implements $ReviewStatsCopyWith<$Res> {
  factory _$$ReviewStatsImplCopyWith(
          _$ReviewStatsImpl value, $Res Function(_$ReviewStatsImpl) then) =
      __$$ReviewStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double averageRating,
      int totalReviews,
      int verifiedReviews,
      Map<String, int> ratingDistribution,
      double percentageRecommend});
}

/// @nodoc
class __$$ReviewStatsImplCopyWithImpl<$Res>
    extends _$ReviewStatsCopyWithImpl<$Res, _$ReviewStatsImpl>
    implements _$$ReviewStatsImplCopyWith<$Res> {
  __$$ReviewStatsImplCopyWithImpl(
      _$ReviewStatsImpl _value, $Res Function(_$ReviewStatsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? averageRating = null,
    Object? totalReviews = null,
    Object? verifiedReviews = null,
    Object? ratingDistribution = null,
    Object? percentageRecommend = null,
  }) {
    return _then(_$ReviewStatsImpl(
      averageRating: null == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double,
      totalReviews: null == totalReviews
          ? _value.totalReviews
          : totalReviews // ignore: cast_nullable_to_non_nullable
              as int,
      verifiedReviews: null == verifiedReviews
          ? _value.verifiedReviews
          : verifiedReviews // ignore: cast_nullable_to_non_nullable
              as int,
      ratingDistribution: null == ratingDistribution
          ? _value._ratingDistribution
          : ratingDistribution // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      percentageRecommend: null == percentageRecommend
          ? _value.percentageRecommend
          : percentageRecommend // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReviewStatsImpl implements _ReviewStats {
  const _$ReviewStatsImpl(
      {required this.averageRating,
      required this.totalReviews,
      required this.verifiedReviews,
      required final Map<String, int> ratingDistribution,
      required this.percentageRecommend})
      : _ratingDistribution = ratingDistribution;

  factory _$ReviewStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewStatsImplFromJson(json);

  @override
  final double averageRating;
  @override
  final int totalReviews;
  @override
  final int verifiedReviews;
  final Map<String, int> _ratingDistribution;
  @override
  Map<String, int> get ratingDistribution {
    if (_ratingDistribution is EqualUnmodifiableMapView)
      return _ratingDistribution;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_ratingDistribution);
  }

  @override
  final double percentageRecommend;

  @override
  String toString() {
    return 'ReviewStats(averageRating: $averageRating, totalReviews: $totalReviews, verifiedReviews: $verifiedReviews, ratingDistribution: $ratingDistribution, percentageRecommend: $percentageRecommend)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewStatsImpl &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating) &&
            (identical(other.totalReviews, totalReviews) ||
                other.totalReviews == totalReviews) &&
            (identical(other.verifiedReviews, verifiedReviews) ||
                other.verifiedReviews == verifiedReviews) &&
            const DeepCollectionEquality()
                .equals(other._ratingDistribution, _ratingDistribution) &&
            (identical(other.percentageRecommend, percentageRecommend) ||
                other.percentageRecommend == percentageRecommend));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      averageRating,
      totalReviews,
      verifiedReviews,
      const DeepCollectionEquality().hash(_ratingDistribution),
      percentageRecommend);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewStatsImplCopyWith<_$ReviewStatsImpl> get copyWith =>
      __$$ReviewStatsImplCopyWithImpl<_$ReviewStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReviewStatsImplToJson(
      this,
    );
  }
}

abstract class _ReviewStats implements ReviewStats {
  const factory _ReviewStats(
      {required final double averageRating,
      required final int totalReviews,
      required final int verifiedReviews,
      required final Map<String, int> ratingDistribution,
      required final double percentageRecommend}) = _$ReviewStatsImpl;

  factory _ReviewStats.fromJson(Map<String, dynamic> json) =
      _$ReviewStatsImpl.fromJson;

  @override
  double get averageRating;
  @override
  int get totalReviews;
  @override
  int get verifiedReviews;
  @override
  Map<String, int> get ratingDistribution;
  @override
  double get percentageRecommend;
  @override
  @JsonKey(ignore: true)
  _$$ReviewStatsImplCopyWith<_$ReviewStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
