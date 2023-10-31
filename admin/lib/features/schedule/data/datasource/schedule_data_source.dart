import 'package:admin/features/schedule/domain/model/schedule_model.dart';
import 'package:admin/shared/exception/http_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ScheduleDataSource {
  Future<Either<AppException, ScheduleModel>> addSchedule(
      {required ScheduleModel scheduleModel});
  Future<Either<AppException, Stream<List<ScheduleModel>>>> streamSchedule();
}

class ScheduleSupabaseDataSource implements ScheduleDataSource {
  final SupabaseClient supabaseClient;
  final tableName = 'schedule';

  ScheduleSupabaseDataSource(this.supabaseClient);

  @override
  Future<Either<AppException, ScheduleModel>> addSchedule(
      {required ScheduleModel scheduleModel}) async {
    try {
      await supabaseClient.from(tableName).insert(
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

  @override
  Future<Either<AppException, Stream<List<ScheduleModel>>>>
      streamSchedule() async {
    try {
      final stream = supabaseClient
          .from(tableName)
          .stream(primaryKey: ['id'])
          .limit(20)
          .map((event) {
            var list = <ScheduleModel>[];
            for (final item in event) {
              list.add(ScheduleModel.fromJson(item));
            }
            return list;
          });
      return Right(stream);
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
