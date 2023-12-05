import 'package:admin/features/schedule/domain/models/schedule_model.dart';
import 'package:admin/shared/exceptions/http_exception.dart';
import 'package:dartz/dartz.dart';

abstract class ScheduleRepository {
  Future<Either<AppException, ScheduleModel>> createSchedule(
      {required ScheduleModel scheduleModel});
  Future<Either<AppException, ScheduleModel>> updateSchedule(
      {required ScheduleModel scheduleModel});
  Future<Either<AppException, bool>> deleteSchedule(
      {required ScheduleModel scheduleModel});
  Future<Either<AppException, Stream<List<ScheduleModel>>>> streamSchedule(
      {required int limit, bool ascending = true});
  Future<Either<AppException, Future<List<ScheduleModel>>>> searchSchedule(
      {required int limit, required String title, bool ascending});
}
