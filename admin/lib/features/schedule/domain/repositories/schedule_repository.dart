import 'package:admin/features/schedule/domain/model/schedule_model.dart';
import 'package:admin/shared/exception/http_exception.dart';
import 'package:dartz/dartz.dart';

abstract class ScheduleRepository {
  Future<Either<AppException, ScheduleModel>> addSchedule(
      {required ScheduleModel scheduleModel});
  Stream<List<ScheduleModel>> streamSchedule();
}
