import 'package:admin/shared/exception/http_exception.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<AppException, bool>> signInWithOtp({required String email});
}
