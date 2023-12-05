import 'dart:async';

import 'package:admin/features/schedule/data/datasource/schedule_data_source.dart';
import 'package:admin/features/schedule/domain/models/schedule_model.dart';
import 'package:admin/shared/constant/page_constant.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../dummy_data.dart';
import '../../../../mocks.dart';
import '../../domain/models/schedule_model_test.dart';

void main() {
  late MockSupabaseService mockSupabaseService;
  late ScheduleDataSource scheduleDataSource;

  setUpAll(() {
    mockSupabaseService = MockSupabaseService();
    scheduleDataSource = ScheduleSupabaseDataSource(mockSupabaseService);
  });

  group(
    'ScheduleDataSource',
    () {
      const limit = pageLimit;

      final StreamController<List<Map<String, dynamic>>> streamController =
          StreamController<List<Map<String, dynamic>>>();
      streamController.add([ktestScheduleMap]);

      test(
        'streamSchedule on success',
        () async {
          when(
            () => mockSupabaseService.stream(
                idKey: ScheduleModel.idKey,
                orderKey: ScheduleModel.dateKey,
                limit: limit),
          ).thenAnswer(
            (_) => streamController.stream,
          );

          final response =
              await scheduleDataSource.streamSchedule(limit: limit);

          expect(response.isRight(), true);
        },
      );

      test(
        'streamSchedule on failure',
        () async {
          when(
            () => mockSupabaseService.stream(
                idKey: ScheduleModel.idKey,
                orderKey: ScheduleModel.dateKey,
                limit: limit),
          ).thenThrow(
            ktestAppException,
          );

          final response =
              await scheduleDataSource.streamSchedule(limit: limit);

          expect(response.isLeft(), true);
        },
      );
    },
  );
}
