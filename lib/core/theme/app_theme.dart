import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  static ThemeData light() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      surface: AppColors.surface,
    );

    return ThemeData(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      cardTheme: const CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          fontWeight: FontWeight.w800,
          color: AppColors.textPrimary,
        ),
        titleLarge: TextStyle(
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        titleSmall: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        bodySmall: TextStyle(color: AppColors.textSecondary),
      ),
    );
  }
}
