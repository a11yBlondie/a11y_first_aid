import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class DecorativeDivider extends StatelessWidget {
  const DecorativeDivider({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO(a11y): [S8 Semantics]
    // Purely decorative, but the screen reader reads "bullet, bullet, bullet,
    // flower, bullet...".
    // Fix: hide it from assistive technologies with ExcludeSemantics.
    //
    //   return const ExcludeSemantics(
    //     child: Padding(...),
    //   );
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Center(
        child: Text(
          '• • • ✿ • • •',
          style: TextStyle(color: AppColors.textSecondary, letterSpacing: 4),
        ),
      ),
    );
  }
}
