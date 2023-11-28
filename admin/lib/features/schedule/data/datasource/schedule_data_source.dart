import 'package:admin/features/schedule/domain/models/schedule_model.dart';
import 'package:admin/shared/exceptions/http_exception.dart';
import 'package:admin/shared/utils/uuid.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ScheduleDataSource {
  Future<Either<AppException, ScheduleModel>> createSchedule(
      {required ScheduleModel scheduleModel});
  Future<Either<AppException, ScheduleModel>> updateSchedule(
      {required ScheduleModel scheduleModel});
  Future<Either<AppException, bool>> deleteSchedule(
      {required ScheduleModel scheduleModel});
  Future<Either<AppException, Stream<List<ScheduleModel>>>> streamSchedule(
      {required int limit});
  Future<Either<AppException, Future<List<ScheduleModel>>>> searchSchedule(
      {required int limit, required String title});
}

class ScheduleSupabaseDataSource implements ScheduleDataSource {
  final SupabaseClient supabaseClient;

  static const tableName = 'schedule';

  ScheduleSupabaseDataSource(this.supabaseClient);

  @override
  Future<Either<AppException, Stream<List<ScheduleModel>>>> streamSchedule(
      {required int limit}) async {
    try {
      final stream = supabaseClient
          .from(tableName)
          .stream(primaryKey: [ScheduleModel.idKey])
          .order(ScheduleModel.createdAtKey, ascending: false)
          .limit(limit)
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
          identifier: '${e.toString()}ScheduleDataSource.streamSchedule',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, ScheduleModel>> createSchedule(
      {required ScheduleModel scheduleModel}) async {
    try {
      await supabaseClient.from(tableName).insert(
        {
          ScheduleModel.idKey: generateNewUuid,
          ScheduleModel.titleKey: scheduleModel.title,
          ScheduleModel.createdAtKey: DateTime.now().toString(),
        },
      );
      return Right(scheduleModel.copyWith.call(id: generateNewUuid));
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
  Future<Either<AppException, ScheduleModel>> updateSchedule(
      {required ScheduleModel scheduleModel}) async {
    try {
      await supabaseClient.from(tableName).update(
        {
          ScheduleModel.titleKey: scheduleModel.title,
        },
      ).match(
        {ScheduleModel.idKey: scheduleModel.id},
      );
      return Right(scheduleModel.copyWith.call(id: generateNewUuid));
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
  Future<Either<AppException, bool>> deleteSchedule(
      {required ScheduleModel scheduleModel}) async {
    try {
      final data = await supabaseClient
          .from(tableName)
          .select()
          .eq(ScheduleModel.idKey, scheduleModel.id);
      if (data is List<dynamic> && data.isEmpty) {
        return Left(
          AppException(
            message: 'Schedule not found!',
            statusCode: 1,
            identifier: 'SCHEDULENOTFOUNDScheduleDataSource.deleteSchedule',
          ),
        );
      }
      await supabaseClient.from(tableName).delete().match(
        {ScheduleModel.idKey: scheduleModel.id},
      );
      return const Right(true);
    } catch (e) {
      return Left(
        AppException(
          message: 'Unknown error occured',
          statusCode: 1,
          identifier: '${e.toString()}ScheduleDataSource.deleteSchedule',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, Future<List<ScheduleModel>>>> searchSchedule(
      {required int limit, required String title}) async {
    try {
      final search = supabaseClient
          .from(tableName)
          .select()
          .ilike(ScheduleModel.titleKey, '%$title%')
          .order(ScheduleModel.createdAtKey, ascending: false)
          .limit(limit)
          .then((event) {
        var list = <ScheduleModel>[];
        for (final item in event) {
          list.add(ScheduleModel.fromJson(item));
        }
        return list;
      });
      return Right(search);
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
