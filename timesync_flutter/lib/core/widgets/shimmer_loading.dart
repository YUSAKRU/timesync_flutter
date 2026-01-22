import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

/// Shimmer Loading Effect
class ShimmerLoading extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final bool isLoading;

  const ShimmerLoading({
    required this.child,
    this.duration = const Duration(milliseconds: 1500),
    this.isLoading = true,
    super.key,
  });

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }

    return AnimatedBuilder(
      animation: _shimmerController,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment(-1.0 - _shimmerController.value * 3, 0),
              end: Alignment(3.0 - _shimmerController.value * 3, 0),
              colors: [
                Colors.grey[800]!,
                Colors.grey[700]!,
                Colors.grey[800]!,
              ],
              stops: const [0.1, 0.5, 0.9],
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
    );
  }
}

/// Shimmer Skeleton Card - for list items
class ShimmerSkeletonCard extends StatelessWidget {
  final double height;
  final EdgeInsets padding;
  final Duration duration;

  const ShimmerSkeletonCard({
    this.height = 100,
    this.padding = const EdgeInsets.all(16),
    this.duration = const Duration(milliseconds: 1500),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ShimmerLoading(
        duration: duration,
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: AppColors.surfaceDark,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

/// Shimmer Skeleton Circle - for avatars
class ShimmerSkeletonCircle extends StatelessWidget {
  final double radius;
  final Duration duration;
  final EdgeInsets padding;

  const ShimmerSkeletonCircle({
    this.radius = 24,
    this.duration = const Duration(milliseconds: 1500),
    this.padding = const EdgeInsets.all(8),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ShimmerLoading(
        duration: duration,
        child: Container(
          width: radius * 2,
          height: radius * 2,
          decoration: const BoxDecoration(
            color: AppColors.surfaceDark,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

/// Shimmer Skeleton Line - for text placeholders
class ShimmerSkeletonLine extends StatelessWidget {
  final double width;
  final double height;
  final Duration duration;
  final EdgeInsets padding;
  final BorderRadius? borderRadius;

  const ShimmerSkeletonLine({
    this.width = double.infinity,
    this.height = 16,
    this.duration = const Duration(milliseconds: 1500),
    this.padding = const EdgeInsets.symmetric(vertical: 8),
    this.borderRadius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ShimmerLoading(
        duration: duration,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: AppColors.surfaceDark,
            borderRadius: borderRadius ?? BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

/// List Item Skeleton - for loading states
class ShimmerListItemSkeleton extends StatelessWidget {
  final Duration duration;
  final EdgeInsets padding;

  const ShimmerListItemSkeleton({
    this.duration = const Duration(milliseconds: 1500),
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ShimmerSkeletonCircle(
                radius: 28,
                duration: duration,
                padding: EdgeInsets.zero,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerSkeletonLine(
                      width: 200,
                      height: 14,
                      duration: duration,
                      padding: EdgeInsets.zero,
                    ),
                    const SizedBox(height: 8),
                    ShimmerSkeletonLine(
                      width: 150,
                      height: 12,
                      duration: duration,
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ShimmerSkeletonLine(
            height: 12,
            duration: duration,
            padding: EdgeInsets.zero,
          ),
          const SizedBox(height: 8),
          ShimmerSkeletonLine(
            width: 250,
            height: 12,
            duration: duration,
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}

/// Card Skeleton - for business/service cards
class ShimmerCardSkeleton extends StatelessWidget {
  final Duration duration;
  final EdgeInsets padding;
  final bool withImage;

  const ShimmerCardSkeleton({
    this.duration = const Duration(milliseconds: 1500),
    this.padding = const EdgeInsets.all(12),
    this.withImage = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (withImage)
              ShimmerLoading(
                duration: duration,
                child: Container(
                  width: double.infinity,
                  height: 160,
                  color: AppColors.backgroundDark,
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerSkeletonLine(
                    width: 200,
                    height: 14,
                    duration: duration,
                    padding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 8),
                  ShimmerSkeletonLine(
                    width: 150,
                    height: 12,
                    duration: duration,
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Full Screen Loading - for page transitions
class ShimmerFullPageSkeleton extends StatelessWidget {
  final Duration duration;
  final int itemCount;

  const ShimmerFullPageSkeleton({
    this.duration = const Duration(milliseconds: 1500),
    this.itemCount = 5,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          itemCount,
          (index) => ShimmerListItemSkeleton(
            duration: duration,
          ),
        ),
      ),
    );
  }
}
