import 'package:admin/routes/app_route.dart';
import 'package:admin/shared/extension/list_extension.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final themeMode = ref.watch(appThemeProvider);
    return MaterialApp.router(
      title: 'Admin',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(useMaterial3: true),
      routerConfig: _appRouter.config(deepLinkBuilder: (deepLink) {
        // Check if path in routes or not
        final route = _appRouter.routes
            .firstWhereOrNull((element) => element.path == deepLink.path);

        if (route == null) {
          return DeepLink.defaultPath;
        }

        return deepLink;
      }),
      debugShowCheckedModeBanner: false,
    );
  }
}
