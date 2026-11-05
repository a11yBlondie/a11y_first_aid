import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class RatingStars extends StatelessWidget {
  const RatingStars({
    super.key,
    required this.rating,
    required this.reviewCount,
  });

  final double rating;
  final int reviewCount;

  @override
  Widget build(BuildContext context) {
    final fullStars = rating.round().clamp(0, 5);

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '★' * fullStars + '☆' * (5 - fullStars),
            style: const TextStyle(color: AppColors.star),
          ),
          TextSpan(text: ' ($reviewCount)'),
        ],
      ),
      semanticsLabel: 'Rated $rating out of 5, $reviewCount reviews',
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}
