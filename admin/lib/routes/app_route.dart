import 'package:admin/features/dashboard/presentation/screens/color_palettes_screen.dart';
import 'package:admin/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:admin/features/dashboard/presentation/screens/elevation_screen.dart';
import 'package:admin/features/dashboard/presentation/screens/typography_screen.dart';
import 'package:admin/features/schedule/presentation/screens/schedule_screen.dart';
import 'package:admin/features/schedule/presentation/screens/new_schedule_screen.dart';
import 'package:admin/features/schedule/presentation/screens/update_schedule_screen.dart';
import 'package:admin/features/splash/presentation/screens/splash_screen.dart';
import 'package:admin/features/auth/presentation/screens/auth_screen.dart';
import 'package:admin/shared/domain/providers/supabase_service_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin/features/schedule/domain/models/schedule_model.dart';
import 'package:flutter/material.dart';

part 'app_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter implements AutoRouteGuard {
  AppRouter({required this.ref});

  final WidgetRef ref;

  @override
  RouteType get defaultRouteType =>
      const RouteType.material(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
        /// routes go here
        AutoRoute(
            page: SplashRoute.page,
            initial: true,
            path: SplashScreen.routeName),
        AutoRoute(
          page: AuthRoute.page,
          path: AuthScreen.routeName,
        ),
        AutoRoute(
          page: DashboardRoute.page,
          path: DashboardScreen.routeName,
          children: [
            RedirectRoute(path: '', redirectTo: ScheduleScreen.routeName),
            AutoRoute(
              path: ScheduleScreen.routeName,
              page: ScheduleRoute.page,
            ),
            AutoRoute(
                path: ColorPalettesScreen.routeName,
                page: ColorPalettesRoute.page),
            AutoRoute(
                path: TypographyScreen.routeName, page: TypographyRoute.page),
            AutoRoute(
                path: ElevationScreen.routeName, page: ElevationRoute.page),
          ],
        ),
        AutoRoute(
          page: NewScheduleRoute.page,
          path: NewScheduleScreen.routeName,
        ),
        AutoRoute(
          page: UpdateScheduleRoute.page,
          path: UpdateScheduleScreen.routeName,
        ),
      ];

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final authenticated =
        ref.watch(supabaseAuthServiceProvider).currentSession != null;

    if (authenticated && resolver.route.name == AuthRoute.name) {
      resolver.next(false);
    } else if (authenticated || resolver.route.name == AuthRoute.name) {
      resolver.next(true);
    } else {
      replace(const AuthRoute());
    }
  }
}
