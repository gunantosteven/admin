import 'package:admin/features/user/data/datasource/user_data_source.dart';
import 'package:admin/features/user/data/repositories/user_repository_impl.dart';
import 'package:admin/features/user/domain/models/user_model.dart';
import 'package:admin/features/user/domain/repositories/user_repository.dart';
import 'package:admin/shared/data/supabase_service.dart';
import 'package:admin/shared/domain/providers/supabase_service_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
UserSupabaseDataSource userDataSource(UserDataSourceRef ref,
    {required SupabaseClient supabaseClient}) {
  return UserSupabaseDataSource(
      SupabaseService(supabaseClient, UserModel.tableName));
}

@riverpod
UserRepository userRepository(UserRepositoryRef ref) {
  final SupabaseClient supabaseClientService =
      ref.watch(supabaseClientServiceProvider);
  final UserDataSource dataSource =
      ref.watch(userDataSourceProvider(supabaseClient: supabaseClientService));
  return UserRepositoryImpl(dataSource);
}
