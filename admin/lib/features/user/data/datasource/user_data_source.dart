import 'package:admin/features/user/domain/models/user_model.dart';
import 'package:admin/shared/data/supabase_service.dart';
import 'package:admin/shared/exceptions/http_exception.dart';
import 'package:dartz/dartz.dart';

abstract class UserDataSource {
  Future<Either<AppException, UserModel>> checkAndCreateUser(
      {required UserModel userModel});
}

class UserSupabaseDataSource implements UserDataSource {
  final SupabaseService supabaseService;

  UserSupabaseDataSource(this.supabaseService);

  @override
  Future<Either<AppException, UserModel>> checkAndCreateUser(
      {required UserModel userModel}) async {
    try {
      // check if user exist or not
      final listData = await supabaseService
          .search(
        columnSearch: UserModel.idKey,
        pattern: userModel.id ?? '',
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
}
