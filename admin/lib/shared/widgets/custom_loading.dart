import 'package:admin/shared/theme/app_color.dart';
import 'package:admin/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomLoading extends ConsumerWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.read(appThemeProvider);
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: themeMode == ThemeMode.light
          ? AppColors.black.withOpacity(0.3)
          : AppColors.white.withOpacity(0.3),
      child: Center(
        child: CircularProgressIndicator(color: AppColors.primary(ref)),
      ),
    );
  }
}
