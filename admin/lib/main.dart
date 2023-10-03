import 'package:admin/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final themeMode = ref.watch(appThemeProvider);
    return MaterialApp.router(
      title: 'Flutter TDD',
      // theme: AppTheme.lightTheme,
      // darkTheme: AppTheme.darkTheme,
      // themeMode: themeMode,
      // routeInformationParser: _appRouter.defaultRouteParser(),
      // routerDelegate: _appRouter.delegate(),
      theme: ThemeData(useMaterial3: true),
      routerConfig: _appRouter.config(),
      debugShowCheckedModeBanner: false,
    );
  }
}
