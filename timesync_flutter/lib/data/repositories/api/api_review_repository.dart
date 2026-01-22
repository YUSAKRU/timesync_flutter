import 'package:dio/dio.dart';

import '../../../core/network/api_config.dart';
import '../../../core/storage/cache_manager.dart';
import '../../models/review_model.dart';
import '../../network/api_client.dart';
import '../result.dart';

/// API Review Repository
/// Handles review-related API calls
class ApiReviewRepository {
  final ApiClient _apiClient = ApiClient.instance;
  final CacheManager? _cacheManager;

  ApiReviewRepository({CacheManager? cacheManager})
      : _cacheManager = cacheManager;

  /// Get reviews for a business
  Future<Result<List<ReviewModel>>> getBusinessReviews({
    required String businessId,
    int? limit,
    int? offset,
    String? sortBy, // 'date' or 'rating'
  }) async {
    try {
      final path =
          ApiConfig.businessReviews.replaceAll('{businessId}', businessId);
      final queryParams = <String, dynamic>{};

      if (limit != null) queryParams['limit'] = limit;
      if (offset != null) queryParams['offset'] = offset;
      if (sortBy != null) queryParams['sort_by'] = sortBy;

      final response = await _apiClient.get(
        path,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? response.data;
        final reviews = data
            .map((json) => ReviewModel.fromJson(json as Map<String, dynamic>))
            .toList();

        // Cache the reviews
        if (_cacheManager != null && offset == null) {
          await _cacheManager!.cacheReviews(businessId, reviews);
        }

        return Result.success(reviews);
      } else {
        // Fallback to cache on error
        if (_cacheManager != null) {
          final cached = _cacheManager!.getCachedReviews(businessId);
          if (cached != null) return Result.success(cached);
        }
        return Result.failure('Yorumlar yüklenemedi');
      }
    } on DioException catch (e) {
      // Offline fallback
      if (_cacheManager != null) {
        final cached = _cacheManager!.getCachedReviews(businessId);
        if (cached != null) return Result.success(cached);
      }
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Get reviews by a user
  Future<Result<List<ReviewModel>>> getUserReviews({
    required String userId,
  }) async {
    try {
      final response = await _apiClient.get(
        '${ApiConfig.reviews}/user/$userId',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? response.data;
        final reviews = data
            .map((json) => ReviewModel.fromJson(json as Map<String, dynamic>))
            .toList();

        return Result.success(reviews);
      } else {
        return Result.failure('Yorumlar yüklenemedi');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Get review by ID
  Future<Result<ReviewModel>> getReviewById(String id) async {
    try {
      final response = await _apiClient.get('${ApiConfig.reviews}/$id');

      if (response.statusCode == 200) {
        final review = ReviewModel.fromJson(
          response.data['data'] ?? response.data,
        );
        return Result.success(review);
      } else {
        return Result.failure('Yorum bulunamadı');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Create review
  Future<Result<ReviewModel>> createReview({
    required String businessId,
    required String userId,
    required String userName,
    required int rating,
    required String comment,
    String? userPhotoUrl,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiConfig.reviews,
        data: {
          'business_id': businessId,
          'user_id': userId,
          'user_name': userName,
          'rating': rating,
          'comment': comment,
          'user_photo_url': userPhotoUrl,
          'date': DateTime.now().toIso8601String(),
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final review = ReviewModel.fromJson(
          response.data['data'] ?? response.data,
        );
        return Result.success(review);
      } else {
        return Result.failure('Yorum eklenemedi');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Yorum eklenemedi');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Update review
  Future<Result<ReviewModel>> updateReview({
    required String reviewId,
    int? rating,
    String? comment,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (rating != null) data['rating'] = rating;
      if (comment != null) data['comment'] = comment;

      final response = await _apiClient.put(
        '${ApiConfig.reviews}/$reviewId',
        data: data,
      );

      if (response.statusCode == 200) {
        final review = ReviewModel.fromJson(
          response.data['data'] ?? response.data,
        );
        return Result.success(review);
      } else {
        return Result.failure('Yorum güncellenemedi');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Delete review
  Future<Result<bool>> deleteReview(String reviewId) async {
    try {
      final response = await _apiClient.delete(
        '${ApiConfig.reviews}/$reviewId',
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return Result.success(true);
      } else {
        return Result.failure('Yorum silinemedi');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Add reply to review (business owner only)
  Future<Result<ReviewModel>> addReply({
    required String reviewId,
    required String reply,
  }) async {
    try {
      final response = await _apiClient.post(
        '${ApiConfig.reviews}/$reviewId/reply',
        data: {'reply': reply},
      );

      if (response.statusCode == 200) {
        final review = ReviewModel.fromJson(
          response.data['data'] ?? response.data,
        );
        return Result.success(review);
      } else {
        return Result.failure('Yanıt eklenemedi');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Get average rating for a business
  Future<Result<double>> getBusinessAverageRating({
    required String businessId,
  }) async {
    try {
      final response = await _apiClient.get(
        '${ApiConfig.businesses}/$businessId/rating',
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] ?? response.data;
        final rating = (data['average_rating'] ?? 0.0).toDouble();
        return Result.success(rating);
      } else {
        return Result.failure('Puan yüklenemedi');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Check if user has reviewed a business
  Future<Result<bool>> hasUserReviewedBusiness({
    required String userId,
    required String businessId,
  }) async {
    try {
      final response = await _apiClient.get(
        '${ApiConfig.reviews}/check',
        queryParameters: {
          'user_id': userId,
          'business_id': businessId,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] ?? response.data;
        final hasReviewed = data['has_reviewed'] ?? false;
        return Result.success(hasReviewed);
      } else {
        return Result.success(false);
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  /// Get review statistics for a business
  Future<Result<Map<String, dynamic>>> getReviewStatistics({
    required String businessId,
  }) async {
    try {
      final response = await _apiClient.get(
        '${ApiConfig.businesses}/$businessId/review-stats',
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] ?? response.data;
        return Result.success(data as Map<String, dynamic>);
      } else {
        return Result.failure('İstatistikler yüklenemedi');
      }
    } on DioException catch (e) {
      return Result.failure(e.error?.toString() ?? 'Bir hata oluştu');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
