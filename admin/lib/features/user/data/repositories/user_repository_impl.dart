import 'package:admin/features/user/data/datasource/user_data_source.dart';
import 'package:admin/features/user/domain/models/user_model.dart';
import 'package:admin/features/user/domain/repositories/user_repository.dart';
import 'package:admin/shared/exceptions/http_exception.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl extends UserRepository {
  final UserDataSource dataSource;

  UserRepositoryImpl(this.dataSource);

  @override
  Future<Either<AppException, UserModel>> createUser(
      {required UserModel userModel}) {
    return dataSource.createUser(userModel: userModel);
  }

  @override
  Future<Either<AppException, UserModel>> getUser({required String id}) {
    return dataSource.getUser(id: id);
  }
}
