import 'package:admin/features/auth/data/datasource/auth_data_source.dart';
import 'package:admin/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:admin/features/auth/domain/repositories/auth_repository.dart';
import 'package:admin/shared/domain/providers/supabase_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:supabase_flutter/supabase_flutter.dart';

final authDataSourceProvider =
    riverpod.Provider.family<AuthDataSource, SupabaseClient>(
  (ref, supabaseClient) {
    final goTrueClient = ref.watch(supabaseAuthServiceProvider);
    return AuthSupabaseDataSource(supabaseClient, goTrueClient);
  },
);

final authRepositoryProvider = riverpod.Provider<AuthRepository>(
  (ref) {
    final SupabaseClient supabaseClientService =
        ref.watch(supabaseServiceProvider);
    final AuthDataSource dataSource =
        ref.watch(authDataSourceProvider(supabaseClientService));
    return AuthRepositoryImpl(dataSource);
  },
);
