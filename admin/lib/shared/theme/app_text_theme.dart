import 'package:admin/shared/theme/app_color.dart';
import 'package:admin/shared/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppTextThemes {
  /// Main text theme

  static TextTheme get textTheme {
    return const TextTheme(
      bodyLarge: AppTextStyles.bodyLg,
      bodyMedium: AppTextStyles.body,
      titleMedium: AppTextStyles.bodySm,
      titleSmall: AppTextStyles.bodyXs,
      displayLarge: AppTextStyles.h1,
      displayMedium: AppTextStyles.h2,
      displaySmall: AppTextStyles.h3,
      headlineMedium: AppTextStyles.h4,
    );
  }

  /// Dark text theme

  static TextTheme get darkTextTheme {
    return TextTheme(
      bodyLarge: AppTextStyles.bodyLg.copyWith(color: AppColors.white),
      bodyMedium: AppTextStyles.body.copyWith(color: AppColors.white),
      titleMedium: AppTextStyles.bodySm.copyWith(color: AppColors.white),
      titleSmall: AppTextStyles.bodyXs.copyWith(color: AppColors.white),
      displayLarge: AppTextStyles.h1.copyWith(color: AppColors.white),
      displayMedium: AppTextStyles.h2.copyWith(color: AppColors.white),
      displaySmall: AppTextStyles.h3.copyWith(color: AppColors.white),
      headlineMedium: AppTextStyles.h4.copyWith(color: AppColors.white),
    );
  }

  /// Primary text theme

  static TextTheme primaryTextTheme(WidgetRef ref) {
    return TextTheme(
      bodyLarge: AppTextStyles.bodyLg.copyWith(color: AppColors.primary(ref)),
      bodyMedium: AppTextStyles.body.copyWith(color: AppColors.primary(ref)),
      titleMedium: AppTextStyles.bodySm.copyWith(color: AppColors.primary(ref)),
      titleSmall: AppTextStyles.bodyXs.copyWith(color: AppColors.primary(ref)),
      displayLarge: AppTextStyles.h1.copyWith(color: AppColors.primary(ref)),
      displayMedium: AppTextStyles.h2.copyWith(color: AppColors.primary(ref)),
      displaySmall: AppTextStyles.h3.copyWith(color: AppColors.primary(ref)),
      headlineMedium: AppTextStyles.h4.copyWith(color: AppColors.primary(ref)),
    );
  }
}
