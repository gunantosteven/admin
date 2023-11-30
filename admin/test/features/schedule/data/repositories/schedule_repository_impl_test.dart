import 'package:admin/features/schedule/data/repositories/schedule_repository_impl.dart';
import 'package:admin/features/schedule/domain/models/schedule_model.dart';
import 'package:admin/features/schedule/domain/repositories/schedule_repository.dart';
import 'package:admin/shared/exceptions/http_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../dummy_data.dart';
import '../../../../mocks.dart';
import '../../domain/models/schedule_model_test.dart';

void main() {
  late MockScheduleDataSource mockScheduleDataSource;
  late ScheduleRepository scheduleRepository;
  setUpAll(() {
    mockScheduleDataSource = MockScheduleDataSource();
    scheduleRepository = ScheduleRepositoryImpl(mockScheduleDataSource);
  });
  group(
    'ScheduleRepository',
    () {
      test(
        'CreateSchedule return ScheduleModel on success',
        () async {
          when(
            () => mockScheduleDataSource.createSchedule(
                scheduleModel: ktestScheduleModel),
          ).thenAnswer(
            (_) async => Right<AppException, ScheduleModel>(ktestScheduleModel),
          );

          final response = await scheduleRepository.createSchedule(
              scheduleModel: ktestScheduleModel);

          expect(response.isRight(), true);
        },
      );

      test(
        'CreateSchedule returns AppException on failure',
        () async {
          when(
            () => mockScheduleDataSource.createSchedule(
                scheduleModel: ktestScheduleModel),
          ).thenAnswer(
            (_) async => Left<AppException, ScheduleModel>(ktestAppException),
          );

          final response = await scheduleRepository.createSchedule(
              scheduleModel: ktestScheduleModel);

          expect(response.isLeft(), true);
        },
      );
    },
  );
}
