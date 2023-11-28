import 'dart:async';

import 'package:admin/features/schedule/domain/models/schedule_model.dart';
import 'package:admin/shared/constant/page_constant.dart';
import 'package:admin/shared/exceptions/http_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../dummy_data.dart';
import '../../../../mocks.dart';
import '../../domain/models/schedule_model_test.dart';

void main() {
  late MockScheduleDataSource mockScheduleDataSource;

  setUpAll(() {
    mockScheduleDataSource = MockScheduleDataSource();
  });

  group(
    'ScheduleDataSource',
    () {
      const limit = pageLimit;

      final StreamController<List<ScheduleModel>> streamController =
          StreamController<List<ScheduleModel>>();
      streamController.add([ktestScheduleModel]);

      test(
        'streamSchedule on success',
        () async {
          final StreamController<List<ScheduleModel>> streamController =
              StreamController<List<ScheduleModel>>();
          streamController.add([ktestScheduleModel]);
          when(
            () => mockScheduleDataSource.streamSchedule(limit: limit),
          ).thenAnswer(
            (_) async => Right<AppException, Stream<List<ScheduleModel>>>(
              streamController.stream,
            ),
          );

          final response =
              await mockScheduleDataSource.streamSchedule(limit: limit);

          expect(response.isRight(), true);
        },
      );

      test(
        'streamSchedule on failure',
        () async {
          when(
            () => mockScheduleDataSource.streamSchedule(limit: limit),
          ).thenAnswer(
            (_) async => Left<AppException, Stream<List<ScheduleModel>>>(
                ktestAppException),
          );

          final response =
              await mockScheduleDataSource.streamSchedule(limit: limit);

          expect(response.isLeft(), true);
        },
      );
    },
  );
}
