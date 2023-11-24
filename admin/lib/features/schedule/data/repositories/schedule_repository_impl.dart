import 'package:admin/features/schedule/data/datasource/schedule_data_source.dart';
import 'package:admin/features/schedule/domain/models/schedule_model.dart';
import 'package:admin/features/schedule/domain/repositories/schedule_repository.dart';
import 'package:admin/shared/exceptions/http_exception.dart';
import 'package:dartz/dartz.dart';

class ScheduleRepositoryImpl extends ScheduleRepository {
  final ScheduleDataSource dataSource;

  ScheduleRepositoryImpl(this.dataSource);

  @override
  Future<Either<AppException, ScheduleModel>> createSchedule(
      {required ScheduleModel scheduleModel}) {
    return dataSource.createSchedule(scheduleModel: scheduleModel);
  }

  @override
  Future<Either<AppException, ScheduleModel>> updateSchedule(
      {required ScheduleModel scheduleModel}) {
    return dataSource.updateSchedule(scheduleModel: scheduleModel);
  }

  @override
  Future<Either<AppException, bool>> deleteSchedule(
      {required ScheduleModel scheduleModel}) {
    return dataSource.deleteSchedule(scheduleModel: scheduleModel);
  }

  @override
  Future<Either<AppException, Stream<List<ScheduleModel>>>> streamSchedule(
      {required int limit}) {
    return dataSource.streamSchedule(limit: limit);
  }

  @override
  Future<Either<AppException, Future<List<ScheduleModel>>>> searchSchedule(
      {required int limit, required String title}) {
    return dataSource.searchSchedule(limit: limit, title: title);
  }
}
