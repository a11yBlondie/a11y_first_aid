import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class DecorativeDivider extends StatelessWidget {
  const DecorativeDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Center(
          child: Text(
            '• • • ✿ • • •',
            style: TextStyle(color: AppColors.textSecondary, letterSpacing: 4),
          ),
        ),
      ),
    );
  }
}
