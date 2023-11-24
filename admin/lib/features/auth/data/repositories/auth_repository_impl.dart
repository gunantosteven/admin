import 'package:admin/features/auth/data/datasource/auth_data_source.dart';
import 'package:admin/features/auth/domain/repositories/auth_repository.dart';
import 'package:admin/shared/exceptions/http_exception.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<Either<AppException, bool>> signUp(
      {required String email, required String password}) {
    return dataSource.signUp(email: email, password: password);
  }

  @override
  Future<Either<AppException, bool>> signInWithOtp({required String email}) {
    return dataSource.signInWithOtp(email: email);
  }

  @override
  Future<Either<AppException, bool>> signInWithPassword(
      {required String email, required String password}) {
    return dataSource.signInWithPassword(
      email: email,
      password: password,
    );
  }
}
