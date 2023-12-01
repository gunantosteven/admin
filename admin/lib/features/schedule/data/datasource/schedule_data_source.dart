import 'package:admin/features/schedule/domain/models/schedule_model.dart';
import 'package:admin/shared/data/supabase_service.dart';
import 'package:admin/shared/exceptions/http_exception.dart';
import 'package:admin/shared/utils/uuid.dart';
import 'package:dartz/dartz.dart';

abstract class ScheduleDataSource {
  Future<Either<AppException, ScheduleModel>> createSchedule(
      {required ScheduleModel scheduleModel});
  Future<Either<AppException, ScheduleModel>> updateSchedule(
      {required ScheduleModel scheduleModel});
  Future<Either<AppException, bool>> deleteSchedule(
      {required ScheduleModel scheduleModel});
  Future<Either<AppException, Stream<List<ScheduleModel>>>> streamSchedule(
      {required int limit, bool ascending});
  Future<Either<AppException, Future<List<ScheduleModel>>>> searchSchedule(
      {required int limit, required String title, bool ascending});
}

class ScheduleSupabaseDataSource implements ScheduleDataSource {
  final SupabaseService supabaseService;

  ScheduleSupabaseDataSource(this.supabaseService);

  @override
  Future<Either<AppException, Stream<List<ScheduleModel>>>> streamSchedule(
      {required int limit, bool ascending = false}) async {
    try {
      final stream = supabaseService
          .stream(
              idKey: ScheduleModel.idKey,
              orderKey: ScheduleModel.createdAtKey,
              ascending: ascending,
              limit: limit)
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
      await supabaseService.insert(
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
      await supabaseService.update(
        {
          ScheduleModel.titleKey: scheduleModel.title,
        },
        match: {ScheduleModel.idKey: scheduleModel.id},
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
      await supabaseService.delete(ScheduleModel.idKey, scheduleModel.id);
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
      {required int limit,
      required String title,
      bool ascending = false}) async {
    try {
      final search = supabaseService
          .search(
              columnSearch: ScheduleModel.titleKey,
              pattern: '%$title%',
              orderKey: ScheduleModel.createdAtKey,
              ascending: ascending,
              limit: limit)
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
