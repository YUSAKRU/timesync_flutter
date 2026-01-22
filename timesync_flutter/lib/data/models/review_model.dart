import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_model.freezed.dart';
part 'review_model.g.dart';

@freezed
class ReviewModel with _$ReviewModel {
  const factory ReviewModel({
    required String id,
    required String businessId,
    required String customerId,
    required String customerName,
    String? customerPhotoUrl,
    required String appointmentId,
    required double rating, // 1.0 - 5.0
    required String title,
    required String comment,
    List<String>? images,
    required bool isVerified, // Purchase verified
    required bool isPublished,
    
    // Business Response
    String? businessResponse,
    DateTime? businessResponseDate,
    String? businessResponderId,
    
    // Metadata
    int? helpfulCount,
    int? unhelpfulCount,
    List<String>? tags,
    bool? isReported,
    
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _ReviewModel;

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);
}

/// Get star rating as list (for UI)
extension ReviewModelExtension on ReviewModel {
  List<bool> get starRating => List.generate(5, (i) => (i + 1) <= rating.toInt());
}

/// Create Review Request
@freezed
class CreateReviewRequest with _$CreateReviewRequest {
  const factory CreateReviewRequest({
    required String appointmentId,
    required double rating,
    required String title,
    required String comment,
    List<String>? images,
    List<String>? tags,
  }) = _CreateReviewRequest;

  factory CreateReviewRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateReviewRequestFromJson(json);
}

/// Business Response Request
@freezed
class BusinessResponseRequest with _$BusinessResponseRequest {
  const factory BusinessResponseRequest({
    required String responseText,
    String? responderId,
  }) = _BusinessResponseRequest;

  factory BusinessResponseRequest.fromJson(Map<String, dynamic> json) =>
      _$BusinessResponseRequestFromJson(json);
}

/// Reviews List Response
@freezed
class ReviewsResponse with _$ReviewsResponse {
  const factory ReviewsResponse({
    required List<ReviewModel> reviews,
    required double averageRating,
    required Map<String, int> ratingDistribution, // "5": 42, "4": 28, etc
    required int totalReviews,
    required int verifiedReviews,
    required bool hasMore,
    required int page,
  }) = _ReviewsResponse;

  factory ReviewsResponse.fromJson(Map<String, dynamic> json) =>
      _$ReviewsResponseFromJson(json);
}

/// Review Statistics
@freezed
class ReviewStats with _$ReviewStats {
  const factory ReviewStats({
    required double averageRating,
    required int totalReviews,
    required int verifiedReviews,
    required Map<String, int> ratingDistribution,
    required double percentageRecommend,
  }) = _ReviewStats;

  factory ReviewStats.fromJson(Map<String, dynamic> json) =>
      _$ReviewStatsFromJson(json);
}
