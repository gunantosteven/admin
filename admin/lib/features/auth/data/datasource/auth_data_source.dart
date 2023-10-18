import 'package:admin/shared/exception/http_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthDataSource {
  Future<Either<AppException, bool>> signInWithOtp({required String email});
}

class AuthSupabaseDataSource implements AuthDataSource {
  final SupabaseClient supabaseClient;
  final GoTrueClient goTrueClient;

  AuthSupabaseDataSource(this.supabaseClient, this.goTrueClient);

  @override
  Future<Either<AppException, bool>> signInWithOtp(
      {required String email}) async {
    try {
      goTrueClient.signInWithOtp(
          email: email,
          emailRedirectTo: kIsWeb
              ? null
              : 'io.supabase.flutterquickstart://login-callback/');
      return const Right(true);
    } catch (e) {
      return Left(
        AppException(
          message: 'Unknown error occured',
          statusCode: 1,
          identifier: '${e.toString()}AuthSupabaseDataSource.loginEmail',
        ),
      );
    }
  }
}
