import 'package:admin/routes/app_route.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../robot.dart';

class AuthRobot {
  AuthRobot(
    this.tester,
  );

  final WidgetTester tester;

  Robot? robot;

  Future<void> replaceScreen() async {
    robot!.appRouter!.replace(const AuthRoute());
    await tester.pumpAndSettle();
  }
}
