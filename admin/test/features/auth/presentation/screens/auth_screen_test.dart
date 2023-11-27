import 'package:admin/features/auth/presentation/screens/auth_screen.dart';
import 'package:admin/shared/widgets/custom_textfield.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../robot.dart';

void main() {
  testWidgets('AuthScreen has a text field email and button login',
      (tester) async {
    final robot = Robot(tester);
    await robot.pumpMyApp();
    await robot.authRobot.replaceScreen();

    final emailTextFieldFinder = find.byType(CustomTextField);
    final loginButtonFinder = find.byKey(AuthScreen.loginButtonKey);

    expect(emailTextFieldFinder, findsOneWidget);
    expect(loginButtonFinder, findsOneWidget);
  });
}
