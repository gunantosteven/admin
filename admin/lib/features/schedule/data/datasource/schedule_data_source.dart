import 'package:admin/features/schedule/domain/model/schedule_model.dart';
import 'package:admin/shared/exception/http_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ScheduleDataSource {
  Future<Either<AppException, ScheduleModel>> addSchedule(
      {required ScheduleModel scheduleModel});
}

class ScheduleSupabaseDataSource implements ScheduleDataSource {
  final SupabaseClient supabaseClient;

  ScheduleSupabaseDataSource(this.supabaseClient);

  @override
  Future<Either<AppException, ScheduleModel>> addSchedule(
      {required ScheduleModel scheduleModel}) async {
    try {
      await supabaseClient.from('schedule').insert(
        {'id': scheduleModel.id, 'job': scheduleModel.job},
      );
      return Right(scheduleModel);
    } catch (e) {
      return Left(
        AppException(
          message: 'Unknown error occured',
          statusCode: 1,
          identifier: '${e.toString()}ScheduleDataSource.addSchedule',
        ),
      );
    }
  }
}
