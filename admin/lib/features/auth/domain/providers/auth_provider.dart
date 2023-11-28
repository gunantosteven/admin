import 'package:admin/features/auth/data/datasource/auth_data_source.dart';
import 'package:admin/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:admin/features/auth/domain/repositories/auth_repository.dart';
import 'package:admin/shared/domain/providers/supabase_service_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@riverpod
AuthSupabaseDataSource authDataSource(AuthDataSourceRef ref,
    {required SupabaseClient supabaseClient}) {
  final goTrueClient = ref.watch(supabaseAuthServiceProvider);
  return AuthSupabaseDataSource(supabaseClient, goTrueClient);
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  final SupabaseClient supabaseClientService =
      ref.watch(supabaseClientServiceProvider);
  final AuthDataSource dataSource =
      ref.watch(authDataSourceProvider(supabaseClient: supabaseClientService));
  return AuthRepositoryImpl(dataSource);
}
