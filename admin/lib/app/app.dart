import 'package:admin/routes/app_route.dart';
import 'package:admin/shared/extension/list_extension.dart';
import 'package:admin/shared/theme/app_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = AppRouter(ref: ref);
    final themeMode = ref.watch(appThemeProvider);
    return MaterialApp.router(
      title: 'Admin',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      themeMode: themeMode,
      theme: AppThemeData.lightTheme(ref),
      darkTheme: AppThemeData.darkTheme(ref),
      routerConfig: appRouter.config(deepLinkBuilder: (deepLink) {
        // Check if path in routes or not
        final route = appRouter.routes.firstWhereOrNull(
            (element) => deepLink.path.startsWith(element.path));

        if (route == null) {
          return DeepLink.defaultPath;
        }

        return deepLink;
      }),
      debugShowCheckedModeBanner: false,
    );
  }
}
