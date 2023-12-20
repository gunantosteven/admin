import 'package:admin/features/user/domain/models/user_model.dart';
import 'package:admin/shared/exceptions/http_exception.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<AppException, UserModel>> createUser(
      {required UserModel userModel});
  Future<Either<AppException, UserModel>> getUser({required String id});
}
