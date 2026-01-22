// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewModelImpl _$$ReviewModelImplFromJson(Map<String, dynamic> json) =>
    _$ReviewModelImpl(
      id: json['id'] as String,
      businessId: json['businessId'] as String,
      customerId: json['customerId'] as String,
      customerName: json['customerName'] as String,
      customerPhotoUrl: json['customerPhotoUrl'] as String?,
      appointmentId: json['appointmentId'] as String,
      rating: (json['rating'] as num).toDouble(),
      title: json['title'] as String,
      comment: json['comment'] as String,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      isVerified: json['isVerified'] as bool,
      isPublished: json['isPublished'] as bool,
      businessResponse: json['businessResponse'] as String?,
      businessResponseDate: json['businessResponseDate'] == null
          ? null
          : DateTime.parse(json['businessResponseDate'] as String),
      businessResponderId: json['businessResponderId'] as String?,
      helpfulCount: (json['helpfulCount'] as num?)?.toInt(),
      unhelpfulCount: (json['unhelpfulCount'] as num?)?.toInt(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      isReported: json['isReported'] as bool?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ReviewModelImplToJson(_$ReviewModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'businessId': instance.businessId,
      'customerId': instance.customerId,
      'customerName': instance.customerName,
      'customerPhotoUrl': instance.customerPhotoUrl,
      'appointmentId': instance.appointmentId,
      'rating': instance.rating,
      'title': instance.title,
      'comment': instance.comment,
      'images': instance.images,
      'isVerified': instance.isVerified,
      'isPublished': instance.isPublished,
      'businessResponse': instance.businessResponse,
      'businessResponseDate': instance.businessResponseDate?.toIso8601String(),
      'businessResponderId': instance.businessResponderId,
      'helpfulCount': instance.helpfulCount,
      'unhelpfulCount': instance.unhelpfulCount,
      'tags': instance.tags,
      'isReported': instance.isReported,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$CreateReviewRequestImpl _$$CreateReviewRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateReviewRequestImpl(
      appointmentId: json['appointmentId'] as String,
      rating: (json['rating'] as num).toDouble(),
      title: json['title'] as String,
      comment: json['comment'] as String,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$CreateReviewRequestImplToJson(
        _$CreateReviewRequestImpl instance) =>
    <String, dynamic>{
      'appointmentId': instance.appointmentId,
      'rating': instance.rating,
      'title': instance.title,
      'comment': instance.comment,
      'images': instance.images,
      'tags': instance.tags,
    };

_$BusinessResponseRequestImpl _$$BusinessResponseRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$BusinessResponseRequestImpl(
      responseText: json['responseText'] as String,
      responderId: json['responderId'] as String?,
    );

Map<String, dynamic> _$$BusinessResponseRequestImplToJson(
        _$BusinessResponseRequestImpl instance) =>
    <String, dynamic>{
      'responseText': instance.responseText,
      'responderId': instance.responderId,
    };

_$ReviewsResponseImpl _$$ReviewsResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ReviewsResponseImpl(
      reviews: (json['reviews'] as List<dynamic>)
          .map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      averageRating: (json['averageRating'] as num).toDouble(),
      ratingDistribution:
          Map<String, int>.from(json['ratingDistribution'] as Map),
      totalReviews: (json['totalReviews'] as num).toInt(),
      verifiedReviews: (json['verifiedReviews'] as num).toInt(),
      hasMore: json['hasMore'] as bool,
      page: (json['page'] as num).toInt(),
    );

Map<String, dynamic> _$$ReviewsResponseImplToJson(
        _$ReviewsResponseImpl instance) =>
    <String, dynamic>{
      'reviews': instance.reviews,
      'averageRating': instance.averageRating,
      'ratingDistribution': instance.ratingDistribution,
      'totalReviews': instance.totalReviews,
      'verifiedReviews': instance.verifiedReviews,
      'hasMore': instance.hasMore,
      'page': instance.page,
    };

_$ReviewStatsImpl _$$ReviewStatsImplFromJson(Map<String, dynamic> json) =>
    _$ReviewStatsImpl(
      averageRating: (json['averageRating'] as num).toDouble(),
      totalReviews: (json['totalReviews'] as num).toInt(),
      verifiedReviews: (json['verifiedReviews'] as num).toInt(),
      ratingDistribution:
          Map<String, int>.from(json['ratingDistribution'] as Map),
      percentageRecommend: (json['percentageRecommend'] as num).toDouble(),
    );

Map<String, dynamic> _$$ReviewStatsImplToJson(_$ReviewStatsImpl instance) =>
    <String, dynamic>{
      'averageRating': instance.averageRating,
      'totalReviews': instance.totalReviews,
      'verifiedReviews': instance.verifiedReviews,
      'ratingDistribution': instance.ratingDistribution,
      'percentageRecommend': instance.percentageRecommend,
    };
