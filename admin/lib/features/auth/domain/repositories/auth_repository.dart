import 'package:admin/shared/exceptions/http_exception.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<AppException, bool>> signUp(
      {required String email, required String password});
  Future<Either<AppException, bool>> signInWithOtp({required String email});
  Future<Either<AppException, bool>> signInWithPassword(
      {required String email, required String password});
}
