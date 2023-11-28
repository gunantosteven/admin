import 'package:admin/features/auth/data/datasource/auth_data_source.dart';
import 'package:admin/features/auth/domain/providers/auth_provider.dart';
import 'package:admin/features/auth/domain/repositories/auth_repository.dart';
import 'package:admin/shared/domain/providers/supabase_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../mocks.dart';

void main() {
  final mockSupabaseClientService = MockSupabaseClientService();
  final mockSupabaseAuthService = MockSupabaseAuthService();
  final providerContainer = ProviderContainer(overrides: [
    supabaseClientServiceProvider.overrideWithValue(mockSupabaseClientService),
    supabaseAuthServiceProvider.overrideWithValue(mockSupabaseAuthService)
  ]);
  late dynamic authDataSource;
  late dynamic authRepository;

  setUpAll(
    () {
      authDataSource = providerContainer.read(
          authDataSourceProvider(supabaseClient: mockSupabaseClientService));
      authRepository = providerContainer.read(authRepositoryProvider);
    },
  );

  test('dataSourceProvider is a AuthDataSource', () {
    expect(
      authDataSource,
      isA<AuthDataSource>(),
    );
  });
  test('authRepositoryProvider is AuthRepository', () {
    expect(
      authRepository,
      isA<AuthRepository>(),
    );
  });
}
