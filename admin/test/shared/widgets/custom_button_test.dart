import 'package:admin/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CustomButton with Type Default', (tester) async {
    var wasPressed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: CustomButton(
          onPressed: () {
            wasPressed = true;
          },
          buttonType: ButtonType.DEFAULT,
          text: 'default',
        ),
      ),
    );

    final buttonFinder = find.byType(CustomButton);
    final textFinder = find.text('default');
    CustomButton customButton = tester.widget<CustomButton>(buttonFinder);
    await tester.tap(buttonFinder);

    expect(customButton.buttonType, ButtonType.DEFAULT);
    expect(textFinder, findsOneWidget);
    expect(wasPressed, true);
  });

  testWidgets('CustomButton with Type Icon', (tester) async {
    var wasPressed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: CustomButton(
          onPressed: () {
            wasPressed = true;
          },
          buttonType: ButtonType.ICON,
          icon: Icons.abc,
        ),
      ),
    );

    final buttonFinder = find.byType(CustomButton);
    CustomButton customButton = tester.widget<CustomButton>(buttonFinder);
    await tester.tap(buttonFinder);

    expect(customButton.buttonType, ButtonType.ICON);
    expect(customButton.icon, Icons.abc);
    expect(wasPressed, true);
  });

  testWidgets('CustomButton with Type Text', (tester) async {
    var wasPressed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: CustomButton(
          onPressed: () {
            wasPressed = true;
          },
          buttonType: ButtonType.TEXT,
          text: 'text',
        ),
      ),
    );

    final buttonFinder = find.byType(CustomButton);
    final textFinder = find.text('text');
    CustomButton customButton = tester.widget<CustomButton>(buttonFinder);
    await tester.tap(buttonFinder);

    expect(customButton.buttonType, ButtonType.TEXT);
    expect(textFinder, findsOneWidget);
    expect(wasPressed, true);
  });
}
