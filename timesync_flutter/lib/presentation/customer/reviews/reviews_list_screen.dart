import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/providers/review/review_provider.dart';
import '../../../data/models/review_model.dart';
import '../../common/custom_network_image.dart';

/// Reviews List Screen - Shows all business reviews
class ReviewsListScreen extends ConsumerStatefulWidget {
  final String businessId;
  final String businessName;

  const ReviewsListScreen({
    required this.businessId,
    required this.businessName,
    super.key,
  });

  @override
  ConsumerState<ReviewsListScreen> createState() => _ReviewsListScreenState();
}

class _ReviewsListScreenState extends ConsumerState<ReviewsListScreen> {
  final _scrollController = ScrollController();
  String _sortBy = 'helpful'; // newest, helpful, lowest

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref
          .read(businessReviewsProvider(widget.businessId).notifier)
          .loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final reviewsState = ref.watch(businessReviewsProvider(widget.businessId));
    final statsAsync = ref.watch(reviewStatsProvider(widget.businessId));

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Yorumlar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              widget.businessName,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: statsAsync.when(
        data: (stats) {
          if (reviewsState.isLoading && reviewsState.reviews.isEmpty) {
            return _buildLoading();
          }
          if (reviewsState.error != null && reviewsState.reviews.isEmpty) {
            return _buildError(reviewsState.error!);
          }
          return _buildReviewsList(reviewsState, stats);
        },
        error: (err, stack) => _buildError(err),
        loading: () => _buildLoading(),
      ),
    );
  }

  Widget _buildReviewsList(ReviewsState state, ReviewStats stats) {
    return Column(
      children: [
        // Rating Summary
        Container(
          padding: const EdgeInsets.all(20),
          color: AppColors.surfaceDark.withValues(alpha: 0.5),
          child: Row(
            children: [
              // Average Rating
              Column(
                children: [
                  Text(
                    stats.averageRating.toStringAsFixed(1),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: List.generate(
                      5,
                      (i) => Icon(
                        i < stats.averageRating
                            ? Icons.star
                            : Icons.star_outline,
                        color: AppColors.primary,
                        size: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${stats.totalReviews} yorum',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 24),

              // Rating Distribution
              Expanded(
                child: Column(
                  children: ['5', '4', '3', '2', '1'].map((rating) {
                    final count = stats.ratingDistribution[rating] ?? 0;
                    final percentage = stats.totalReviews > 0
                        ? (count / stats.totalReviews * 100).toInt()
                        : 0;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Text(
                            '$rating ⭐',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: percentage / 100,
                                backgroundColor: Colors.grey[800],
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.primary.withValues(
                                    alpha: 0.5 + (percentage / 100) * 0.5,
                                  ),
                                ),
                                minHeight: 4,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 40,
                            child: Text(
                              '%$percentage',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 11,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),

        // Sort Options
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(
                'Sırala:',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 12),
              ...[
                ('helpful', 'Yararlı'),
                ('newest', 'En Yeni'),
                ('lowest', 'En Düşük'),
              ].map((option) {
                final isSelected = _sortBy == option.$1;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: FilterChip(
                    label: Text(option.$2),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() => _sortBy = option.$1);
                    },
                    backgroundColor: AppColors.surfaceDark,
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? AppColors.backgroundDark
                          : Colors.grey[300],
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),

        // Reviews List
        Expanded(
          child: state.reviews.isEmpty
              ? Center(
                  child: Text(
                    'Henüz yorum yok',
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                )
              : ListView.builder(
                  controller: _scrollController,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: state.reviews.length + (state.hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == state.reviews.length) {
                      return const Padding(
                        padding: EdgeInsets.all(24),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                            strokeWidth: 2,
                          ),
                        ),
                      );
                    }

                    final review = state.reviews[index];
                    return _buildReviewCard(review);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildReviewCard(ReviewModel review) {
    final dateFormatter = DateFormat('dd MMMM yyyy', 'tr_TR');
    final formattedDate = dateFormatter.format(review.createdAt);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: AppColors.surfaceDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Avatar, Name, Rating, Date
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomNetworkImage(
                  imageUrl: review.customerPhotoUrl ?? '',
                  width: 48,
                  height: 48,
                  isCircle: true,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.customerName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          ...List.generate(
                            5,
                            (i) => Icon(
                              i < review.rating
                                  ? Icons.star
                                  : Icons.star_outline,
                              color: AppColors.primary,
                              size: 12,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            formattedDate,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 11,
                            ),
                          ),
                          if (review.isVerified)
                            const Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Row(
                                children: [
                                  Icon(Icons.verified,
                                      color: AppColors.primary, size: 12),
                                  SizedBox(width: 2),
                                  Text(
                                    'Doğrulanmış',
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Title & Comment
            Text(
              review.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              review.comment,
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 13,
                height: 1.5,
              ),
            ),

            // Images (if any)
            if (review.images != null && review.images!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: review.images!.length,
                    itemBuilder: (context, i) => Padding(
                      padding: EdgeInsets.only(
                          right: i < review.images!.length - 1 ? 8 : 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 80,
                          color: Colors.grey[800],
                          child: Icon(Icons.image, color: Colors.grey[600]),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            // Business Response (if any)
            if (review.businessResponse != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'İşletmenin Yanıtı',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        review.businessResponse!,
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Helpful / Unhelpful
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                children: [
                  TextButton.icon(
                    onPressed: () {
                      ref.read(markReviewHelpfulProvider((
                        reviewId: review.id,
                        isHelpful: true,
                      )).future);
                    },
                    icon: Icon(Icons.thumb_up_outlined,
                        size: 14, color: Colors.grey[500]),
                    label: Text(
                      'Yararlı (${review.helpfulCount ?? 0})',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 11,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  TextButton.icon(
                    onPressed: () {
                      ref.read(markReviewHelpfulProvider((
                        reviewId: review.id,
                        isHelpful: false,
                      )).future);
                    },
                    icon: Icon(Icons.thumb_down_outlined,
                        size: 14, color: Colors.grey[500]),
                    label: Text(
                      'Yararlı Değil (${review.unhelpfulCount ?? 0})',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 11,
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(Icons.flag_outlined,
                        size: 16, color: Colors.grey[600]),
                    onPressed: () {
                      ref.read(reportReviewProvider((
                        reviewId: review.id,
                        reason: 'inappropriate',
                      )).future);
                    },
                    tooltip: 'Bildir',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(Object error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
          const SizedBox(height: 16),
          Text(
            'Hata Oluştu',
            style: TextStyle(
              color: Colors.red[400],
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            error.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppColors.primary),
          SizedBox(height: 16),
          Text(
            'Yorumlar yükleniyor...',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
