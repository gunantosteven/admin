import 'package:admin/features/auth/data/datasource/auth_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../dummy_data.dart';
import '../../../../mocks.dart';

void main() {
  late AuthDataSource authDataSource;
  late MockSupabaseService mockSupabaseService;
  late MockSupabaseAuthService mockSupabaseAuthService;
  setUpAll(() {
    mockSupabaseService = MockSupabaseService();
    mockSupabaseAuthService = MockSupabaseAuthService();
    authDataSource = AuthSupabaseDataSource(
      mockSupabaseService,
      mockSupabaseAuthService,
    );
  });
  group(
    'AuthDataSource',
    () {
      const email = 'dummy';
      const pass = 'dummy';

      test(
        'Sign Up returns bool on success',
        () async {
          when(
            () => mockSupabaseAuthService.signUp(email: email, password: pass),
          ).thenAnswer(
            (_) async => AuthResponse(),
          );

          final response =
              await authDataSource.signUp(email: email, password: pass);

          expect(response.isRight(), true);
        },
      );

      test(
        'Sign Up returns AppException on failure',
        () async {
          when(
            () => mockSupabaseAuthService.signUp(email: email, password: pass),
          ).thenThrow(ktestAppException);

          final response =
              await authDataSource.signUp(email: email, password: pass);

          expect(response.isLeft(), true);
        },
      );
    },
  );
}
