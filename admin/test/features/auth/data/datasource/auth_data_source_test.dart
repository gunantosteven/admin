import 'package:admin/features/auth/data/datasource/auth_data_source.dart';
import 'package:admin/shared/exception/http_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixture/dummy_data.dart';

class MockAuthDataSource extends Mock implements AuthDataSource {}

void main() {
  late MockAuthDataSource mockAuthDataSource;
  setUpAll(() {
    mockAuthDataSource = MockAuthDataSource();
  });
  group(
    'Auth',
    () {
      test(
        'Sign Up returns bool on success',
        () async {
          when(() => mockAuthDataSource.signUp(
              email: 'email', password: 'password')).thenAnswer(
            (_) async => const Right<AppException, bool>(true),
          );

          final response = await mockAuthDataSource.signUp(
              email: 'email', password: 'password');

          expect(response.isRight(), true);
        },
      );

      test(
        'Sign Up returns AppException on failure',
        () async {
          when(() => mockAuthDataSource.signUp(
              email: 'email', password: 'password')).thenAnswer(
            (_) async => Left<AppException, bool>(
              ktestAppException,
            ),
          );

          final response = await mockAuthDataSource.signUp(
              email: 'email', password: 'password');

          expect(response.isLeft(), true);
        },
      );
    },
  );
}
