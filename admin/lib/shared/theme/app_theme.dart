import 'package:admin/shared/theme/app_color.dart';
import 'package:admin/shared/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_theme.g.dart';

///
@riverpod
class AppTheme extends _$AppTheme {
  @override
  ThemeMode build() {
    return ThemeMode.dark;
  }

  void toggleTheme() {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }
}

class AppThemeData {
  static ThemeData darkTheme(WidgetRef ref) {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      // fontFamily: AppTextStyles.fontFamily,
      primaryColor: AppColors.primary(ref),
      textTheme: AppTextThemes.darkTextTheme,
      colorScheme: colorSchemeDarkM3,
      primaryTextTheme: AppTextThemes.primaryTextTheme(ref),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.primary(ref),
        foregroundColor: AppColors.black,
      ),
    );
  }

  /// Light theme data of the app
  static ThemeData lightTheme(WidgetRef ref) {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      primaryColor: AppColors.primary(ref),
      textTheme: AppTextThemes.textTheme,
      primaryTextTheme: AppTextThemes.primaryTextTheme(ref),
      colorScheme: colorSchemeLightM3,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.primary(ref),
        foregroundColor: AppColors.white,
      ),
    );
  }
}
