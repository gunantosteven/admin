import 'package:admin/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:admin/features/auth/domain/repositories/auth_repository.dart';
import 'package:admin/shared/exception/http_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../dummy_data.dart';
import '../datasource/auth_data_source_test.dart';

void main() {
  late MockAuthDataSource mockAuthDataSource;
  late AuthRepository authRepository;
  setUpAll(() {
    mockAuthDataSource = MockAuthDataSource();
    authRepository = AuthRepositoryImpl(mockAuthDataSource);
  });
  group(
    'AuthRepository',
    () {
      const testEmail = 'dummy';
      const testPass = 'dummy';

      test(
        'Sign Up returns bool on success',
        () async {
          when(
            () =>
                mockAuthDataSource.signUp(email: testEmail, password: testPass),
          ).thenAnswer(
            (_) async => const Right<AppException, bool>(true),
          );

          final response =
              await authRepository.signUp(email: testEmail, password: testPass);

          expect(response.isRight(), true);
        },
      );

      test(
        'Sign Up returns AppException on failure',
        () async {
          when(() => mockAuthDataSource.signUp(
              email: testEmail, password: testPass)).thenAnswer(
            (_) async => Left<AppException, bool>(
              ktestAppException,
            ),
          );

          final response =
              await authRepository.signUp(email: testEmail, password: testPass);

          expect(response.isLeft(), true);
        },
      );
    },
  );
}
