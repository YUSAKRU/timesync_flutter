import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timesync_flutter/core/providers/storage_providers.dart';
import 'package:timesync_flutter/data/models/review_model.dart';
import 'package:timesync_flutter/data/repositories/api/api_review_repository.dart';

// Review Repository Provider
final reviewRepositoryProvider = Provider<ApiReviewRepository>((ref) {
  final cacheManager = ref.watch(cacheManagerProvider);
  return ApiReviewRepository(cacheManager: cacheManager);
});

// Business Reviews Provider
class ReviewsState {
  final List<ReviewModel> reviews;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? error;
  final int page;
  final double averageRating;
  final Map<String, int> ratingDistribution;
  final int totalReviews;

  ReviewsState({
    required this.reviews,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.error,
    this.page = 1,
    this.averageRating = 0,
    this.ratingDistribution = const {},
    this.totalReviews = 0,
  });

  ReviewsState copyWith({
    List<ReviewModel>? reviews,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? error,
    int? page,
    double? averageRating,
    Map<String, int>? ratingDistribution,
    int? totalReviews,
  }) {
    return ReviewsState(
      reviews: reviews ?? this.reviews,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      error: error,
      page: page ?? this.page,
      averageRating: averageRating ?? this.averageRating,
      ratingDistribution: ratingDistribution ?? this.ratingDistribution,
      totalReviews: totalReviews ?? this.totalReviews,
    );
  }
}

class ReviewsNotifier extends StateNotifier<ReviewsState> {
  final String businessId;

  ReviewsNotifier(ApiReviewRepository repository, this.businessId)
      : super(ReviewsState(reviews: [])) {
    loadReviews();
  }

  Future<void> loadReviews({bool isRefresh = true}) async {
    if (isRefresh) {
      state =
          state.copyWith(isLoading: true, page: 1, reviews: [], hasMore: true);
    } else {
      if (!state.hasMore || state.isLoadingMore) return;
      state = state.copyWith(isLoadingMore: true);
    }

    try {
      // Mock data logic for now as in the original provider
      await Future.delayed(const Duration(milliseconds: 800));

      final mockReviews = List.generate(
        10,
        (i) => ReviewModel(
          id: 'review_${(state.page - 1) * 10 + i}',
          businessId: businessId,
          customerId: 'customer_${i % 5}',
          customerName: 'Müşteri ${((state.page - 1) * 10) + i + 1}',
          customerPhotoUrl:
              'https://i.pravatar.cc/150?img=${((state.page - 1) * 10 + i) % 50}',
          appointmentId: 'appt_$i',
          rating: (i % 5) + 1.0,
          title: 'Harika bir hizmet!',
          comment:
              'Çok profesyonel ve hızlı bir hizmet aldım. Kesinlikle tavsiye ederim.',
          images: i % 3 == 0 ? ['image_1.jpg', 'image_2.jpg'] : null,
          isVerified: i % 2 == 0,
          isPublished: true,
          businessResponse:
              i % 3 == 0 ? 'Bizi tercih ettiğiniz için teşekkür ederiz!' : null,
          helpfulCount: (i + 1) * 2,
          unhelpfulCount: i,
          tags: ['profesyonel', 'hızlı', 'temiz'],
          createdAt: DateTime.now()
              .subtract(Duration(days: (state.page - 1) * 10 + i)),
        ),
      );

      final updatedReviews =
          isRefresh ? mockReviews : [...state.reviews, ...mockReviews];

      state = state.copyWith(
        reviews: updatedReviews,
        isLoading: false,
        isLoadingMore: false,
        hasMore: state.page < 5, // Mock limit
        page: state.page + 1,
        averageRating: 4.5,
        totalReviews: 100,
        ratingDistribution: {
          '5': 35,
          '4': 25,
          '3': 20,
          '2': 15,
          '1': 5,
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isLoadingMore: false,
        error: e.toString(),
      );
    }
  }

  Future<void> loadNextPage() async {
    await loadReviews(isRefresh: false);
  }
}

final businessReviewsProvider =
    StateNotifierProvider.family<ReviewsNotifier, ReviewsState, String>(
        (ref, businessId) {
  final repository = ref.watch(reviewRepositoryProvider);
  return ReviewsNotifier(repository, businessId);
});

// Create Review Provider
final createReviewProvider =
    FutureProvider.family<ReviewModel, CreateReviewRequest>(
        (ref, request) async {
  final repository = ref.watch(reviewRepositoryProvider);

  // Mock creation
  await Future.delayed(const Duration(milliseconds: 600));

  return ReviewModel(
    id: 'review_new',
    businessId: 'business_1',
    customerId: 'user_1',
    customerName: 'Benim Adım',
    appointmentId: request.appointmentId,
    rating: request.rating,
    title: request.title,
    comment: request.comment,
    images: request.images,
    isVerified: true,
    isPublished: false, // Awaiting moderation
    tags: request.tags,
    createdAt: DateTime.now(),
  );
});

// Add Business Response Provider
final addBusinessResponseProvider = FutureProvider.family<
    ReviewModel,
    ({
      String reviewId,
      BusinessResponseRequest request,
    })>((ref, params) async {
  final repository = ref.watch(reviewRepositoryProvider);

  // Mock response
  await Future.delayed(const Duration(milliseconds: 500));

  ref.invalidate(businessReviewsProvider);

  return ReviewModel(
    id: params.reviewId,
    businessId: 'business_1',
    customerId: 'customer_1',
    customerName: 'Müşteri',
    appointmentId: 'appt_1',
    rating: 4.0,
    title: 'Harika',
    comment: 'Mükemmel hizmet',
    isVerified: true,
    isPublished: true,
    businessResponse: params.request.responseText,
    businessResponseDate: DateTime.now(),
    createdAt: DateTime.now(),
  );
});

// Review Statistics Provider
final reviewStatsProvider =
    FutureProvider.family<ReviewStats, String>((ref, businessId) async {
  await Future.delayed(const Duration(milliseconds: 600));

  return const ReviewStats(
    averageRating: 4.5,
    totalReviews: 100,
    verifiedReviews: 75,
    ratingDistribution: {
      '5': 35,
      '4': 25,
      '3': 20,
      '2': 15,
      '1': 5,
    },
    percentageRecommend: 92.0,
  );
});

// Helpful Vote Provider
final markReviewHelpfulProvider =
    FutureProvider.family<void, ({String reviewId, bool isHelpful})>(
        (ref, params) async {
  // Mock API call
  await Future.delayed(const Duration(milliseconds: 300));

  // Invalidate reviews
  ref.invalidate(businessReviewsProvider);
});

// Report Review Provider
final reportReviewProvider =
    FutureProvider.family<void, ({String reviewId, String reason})>(
        (ref, params) async {
  // Mock API call
  await Future.delayed(const Duration(milliseconds: 300));
});

// User's Own Reviews Provider
final userReviewsProvider = FutureProvider<List<ReviewModel>>((ref) async {
  await Future.delayed(const Duration(milliseconds: 600));

  return List.generate(
    5,
    (i) => ReviewModel(
      id: 'my_review_$i',
      businessId: 'business_$i',
      customerId: 'user_1',
      customerName: 'Ben',
      appointmentId: 'appt_$i',
      rating: 4.5,
      title: 'Çok iyi',
      comment: 'Mükemmel bir deneyim yaşadım.',
      isVerified: true,
      isPublished: true,
      createdAt: DateTime.now().subtract(Duration(days: i * 7)),
    ),
  );
});
