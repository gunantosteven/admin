import 'dart:async';

import 'package:admin/features/schedule/domain/models/schedule_model.dart';
import 'package:admin/features/schedule/domain/providers/schedule_provider.dart';
import 'package:admin/routes/app_route.dart';
import 'package:admin/shared/constant/page_constant.dart';
import 'package:admin/shared/exceptions/http_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../robot.dart';
import 'domain/models/schedule_model_test.dart';

class ScheduleRobot {
  ScheduleRobot(
    this.tester,
  );

  final WidgetTester tester;

  Robot? robot;

  Future<void> replaceScreen() async {
    robot!.appRouter!.replace(const ScheduleRoute());
    await tester.pumpAndSettle();
  }

  void addListSchedule() {
    final StreamController<List<ScheduleModel>> streamController =
        StreamController<List<ScheduleModel>>();
    streamController.add([ktestScheduleModel]);
    when(
      () => robot!.ref!.read(scheduleRepositoryProvider).streamSchedule(
            limit: pageLimit,
          ),
    ).thenAnswer(
      (_) async => Right<AppException, Stream<List<ScheduleModel>>>(
        streamController.stream,
      ),
    );
  }
}
