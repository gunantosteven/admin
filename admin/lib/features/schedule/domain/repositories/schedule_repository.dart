import 'package:admin/features/schedule/domain/model/schedule_model.dart';
import 'package:admin/shared/exception/http_exception.dart';
import 'package:dartz/dartz.dart';

abstract class ScheduleRepository {
  Future<Either<AppException, Stream<List<ScheduleModel>>>> streamSchedule(
      {required int limit});
  Future<Either<AppException, ScheduleModel>> createSchedule(
      {required ScheduleModel scheduleModel});
  Future<Either<AppException, ScheduleModel>> updateSchedule(
      {required ScheduleModel scheduleModel});
  Future<Either<AppException, bool>> deleteSchedule(
      {required ScheduleModel scheduleModel});
}
