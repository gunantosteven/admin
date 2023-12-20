import 'package:admin/features/user/domain/models/user_model.dart';
import 'package:admin/shared/data/supabase_service.dart';
import 'package:admin/shared/exceptions/http_exception.dart';
import 'package:dartz/dartz.dart';

abstract class UserDataSource {
  Future<Either<AppException, UserModel>> createUser(
      {required UserModel userModel});
  Future<Either<AppException, UserModel>> getUser({required String id});
}

class UserSupabaseDataSource implements UserDataSource {
  final SupabaseService supabaseService;

  UserSupabaseDataSource(this.supabaseService);

  @override
  Future<Either<AppException, UserModel>> createUser(
      {required UserModel userModel}) async {
    try {
      await supabaseService.insert(
        {
          UserModel.idKey: userModel.id,
          UserModel.nameKey: userModel.name,
          UserModel.authIdKey: userModel.authId,
        },
      );
      return Right(userModel);
    } catch (e) {
      return Left(
        AppException(
          message: 'Unknown error occured',
          statusCode: 1,
          identifier: '${e.toString()}UserSupabaseDataSource.createUser',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, UserModel>> getUser({required String id}) async {
    try {
      // check if user exist or not
      final listData = await supabaseService
          .filter(
        columnSearch: UserModel.idKey,
        value: id,
      )
          .then((event) {
        var list = <UserModel>[];
        for (final item in event) {
          list.add(UserModel.fromJson(item));
        }
        return list;
      });

      if (listData.isNotEmpty) {
        return Right(listData.first);
      }

      return Left(
        AppException(
          message: 'User not found',
          statusCode: 1,
          identifier: 'UserSupabaseDataSource.getUser',
        ),
      );
    } catch (e) {
      return Left(
        AppException(
          message: 'Unknown error occured',
          statusCode: 1,
          identifier: '${e.toString()}UserSupabaseDataSource.getUser',
        ),
      );
    }
  }
}
