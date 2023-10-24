import 'package:admin/features/schedule/presentation/screens/schedule_screen.dart';
import 'package:admin/features/schedule/presentation/screens/new_schedule_screen.dart';
import 'package:admin/features/splash/presentation/screens/splash_screen.dart';
import 'package:admin/features/auth/presentation/screens/auth_screen.dart';
import 'package:auto_route/auto_route.dart';

part 'app_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
// @override
// replaceInRouteName

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
        AutoRoute(page: AuthRoute.page, path: AuthScreen.routeName),
        AutoRoute(page: ScheduleRoute.page, path: ScheduleScreen.routeName),
        AutoRoute(
            page: NewScheduleRoute.page, path: NewScheduleScreen.routeName),
      ];
}
