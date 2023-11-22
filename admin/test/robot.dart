import 'package:admin/app/app.dart';
import 'package:admin/routes/app_route.dart';
import 'package:admin/shared/domain/providers/supabase_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'features/auth/auth_robot.dart';
import 'mocks.dart';

class Robot {
  Robot(this.tester) : auth = AuthRobot(tester);

  final WidgetTester tester;
  final AuthRobot auth;

  AppRouter? appRouter;

  Future<void> pumpMyApp() async {
    final container = ProviderContainer(
      overrides: [
        supabaseServiceProvider.overrideWithValue(MockSupabaseService()),
        supabaseAuthServiceProvider.overrideWithValue(MockSupabaseAuthService())
      ],
    );

    // init Robot Parent in Robot Child
    auth.robot = this;

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: Consumer(
          builder: (context, ref, child) {
            appRouter = AppRouter(
              ref: ref,
              isNoGuard: true,
            );
            return MyApp(
              router: appRouter,
            );
          },
        ),
      ),
    );
    await tester.pumpAndSettle();
  }
}
