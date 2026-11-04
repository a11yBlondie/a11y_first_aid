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

    // TODO(a11y): [S5 Semantics]
    // The stars are read as "black star, black star, white star..." and "(128)"
    // has no context.
    // Fix: replace what is spoken with one clear sentence. Text.rich has a
    // semanticsLabel parameter, just like Text.
    //
    //   return Text.rich(
    //     TextSpan(...),
    //     semanticsLabel: 'Rated $rating out of 5, $reviewCount reviews',
    //     style: ...,
    //   );
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
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}
