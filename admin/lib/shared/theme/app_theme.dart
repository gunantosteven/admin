import 'package:flutter/material.dart';
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

// final appThemeProvider = StateNotifierProvider<AppThemeModeNotifier, ThemeMode>(
//   (ref) {
//     final storage = ref.watch(storageServiceProvider);
//     return AppThemeModeNotifier(storage);
//   },
// );

// class AppThemeModeNotifier extends StateNotifier<ThemeMode> {
//   final StroageService stroageService;

//   ThemeMode currentTheme = ThemeMode.light;

//   AppThemeModeNotifier(this.stroageService) : super(ThemeMode.light) {
//     getCurrentTheme();
//   }

//   void toggleTheme() {
//     state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
//     stroageService.set(APP_THEME_STORAGE_KEY, state.name);
//   }

//   void getCurrentTheme() async {
//     final theme = await stroageService.get(APP_THEME_STORAGE_KEY);
//     final value = ThemeMode.values.byName('${theme ?? 'light'}');
//     state = value;
//   }
// }

class AppThemeData {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      // fontFamily: AppTextStyles.fontFamily,
      // primaryColor: AppColors.primary,
      // colorScheme: const ColorScheme.dark(
      //   primary: AppColors.primary,
      //   secondary: AppColors.lightGrey,
      //   error: AppColors.error,
      //   background: AppColors.black,
      // ),
      // backgroundColor: AppColors.black,
      // scaffoldBackgroundColor: AppColors.black,
      // textTheme: TextThemes.darkTextTheme,
      // primaryTextTheme: TextThemes.primaryTextTheme,
      // appBarTheme: const AppBarTheme(
      //   elevation: 0,
      //   backgroundColor: AppColors.black,
      //   titleTextStyle: AppTextStyles.h2,
      // ),
    );
  }

  /// Light theme data of the app
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      // primaryColor: AppColors.primary,
      // textTheme: TextThemes.textTheme,
      // primaryTextTheme: TextThemes.primaryTextTheme,
      // colorScheme: const ColorScheme.light(
      //   primary: AppColors.primary,
      //   secondary: AppColors.lightGrey,
      //   error: AppColors.error,
      // ),
      // appBarTheme: const AppBarTheme(
      //   elevation: 0,
      //   backgroundColor: AppColors.primary,
      // ),
    );
  }
}
