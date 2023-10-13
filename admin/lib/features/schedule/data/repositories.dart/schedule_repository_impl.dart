import 'package:admin/features/schedule/data/datasource/schedule_data_source.dart';
import 'package:admin/features/schedule/domain/model/schedule_model.dart';
import 'package:admin/features/schedule/domain/repositories/schedule_repository.dart';
import 'package:admin/shared/exception/http_exception.dart';
import 'package:dartz/dartz.dart';

class ScheduleRepositoryImpl extends ScheduleRepository {
  final ScheduleDataSource dataSource;

  ScheduleRepositoryImpl(this.dataSource);

  @override
  Future<Either<AppException, ScheduleModel>> addSchedule(
      {required ScheduleModel scheduleModel}) {
    return dataSource.addSchedule(scheduleModel: scheduleModel);
  }
}
