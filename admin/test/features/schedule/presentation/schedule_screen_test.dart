import 'dart:async';

import 'package:admin/features/schedule/presentation/widgets/custom_list_schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../robot.dart';
import '../domain/models/schedule_model_test.dart';

void main() {
  testWidgets('ScheduleScreen has a CustomListSchedule widget', (tester) async {
    final robot = Robot(tester);
    await robot.pumpMyApp();
    robot.scheduleRobot.addListSchedule();
    await robot.scheduleRobot.replaceScreen();

    final customListScheduleFinder = find.byType(CustomListSchedule);
    final titleScheduleFinder = find.text(ktestScheduleModel.title);

    expect(customListScheduleFinder, findsOneWidget);
    expect(titleScheduleFinder, findsOneWidget);
  });
}
