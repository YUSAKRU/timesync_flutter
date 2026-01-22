import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import 'shimmer_loading.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double borderRadius;
  final bool isCircle;

  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = 0,
    this.isCircle = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: isCircle
          ? BorderRadius.circular(width ?? height ?? 100)
          : BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => isCircle
            ? ShimmerLoading.circular(
                width: width ?? 50,
                height: height ?? 50,
              )
            : ShimmerLoading.rectangular(
                height: height ?? 200,
                width: width ?? double.infinity,
              ),
        errorWidget: (context, url, error) => Container(
          width: width,
          height: height,
          color: AppColors.surfaceDark,
          child: const Icon(
            Icons.image_not_supported_outlined,
            color: Colors.grey,
            size: 24,
          ),
        ),
      ),
    );
  }
}
