import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class OrganicBadge extends StatelessWidget {
  const OrganicBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.organic,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        '✦ Organic ✦',
        semanticsLabel: 'Organic',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
