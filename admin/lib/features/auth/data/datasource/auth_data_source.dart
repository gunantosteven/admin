import 'package:admin/shared/exception/http_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthDataSource {
  Future<Either<AppException, bool>> signUp(
      {required String email, required String password});
  Future<Either<AppException, bool>> signInWithOtp({required String email});
  Future<Either<AppException, bool>> signInWithPassword(
      {required String email, required String password});
}

class AuthSupabaseDataSource implements AuthDataSource {
  final SupabaseClient supabaseClient;
  final GoTrueClient goTrueClient;

  AuthSupabaseDataSource(this.supabaseClient, this.goTrueClient);

  @override
  Future<Either<AppException, bool>> signUp(
      {required String email, required String password}) async {
    try {
      await goTrueClient.signUp(
        email: email,
        password: password,
      );
      return const Right(true);
    } catch (e) {
      return Left(
        AppException(
          message: 'Unknown error occured',
          statusCode: 1,
          identifier: '${e.toString()}AuthSupabaseDataSource.signUp',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, bool>> signInWithOtp(
      {required String email}) async {
    try {
      await goTrueClient.signInWithOtp(
          email: email,
          emailRedirectTo: kIsWeb
              ? null
              : 'io.supabase.flutterquickstart://login-callback/');
      return const Right(true);
    } catch (e) {
      if (e is AuthException) {
        return Left(
          AppException(
            message: e.message,
            statusCode: 1,
            identifier: '${e.toString()}AuthSupabaseDataSource.loginEmail',
          ),
        );
      }
      return Left(
        AppException(
          message: 'Unknown error occured',
          statusCode: 1,
          identifier: '${e.toString()}AuthSupabaseDataSource.loginEmail',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, bool>> signInWithPassword(
      {required String email, required String password}) async {
    try {
      final response = await goTrueClient.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user != null) {
        return const Right(true);
      }
      return Left(
        AppException(
          message: 'Unknown error occured',
          statusCode: 1,
          identifier: 'User is null signInWithPassword.loginEmail',
        ),
      );
    } catch (e) {
      return Left(
        AppException(
          message: 'Unknown error occured',
          statusCode: 1,
          identifier: '${e.toString()}signInWithPassword.loginEmail',
        ),
      );
    }
  }
}
