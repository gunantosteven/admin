import 'package:admin/features/schedule/data/datasource/schedule_data_source.dart';
import 'package:admin/features/schedule/data/repositories/schedule_repository_impl.dart';
import 'package:admin/features/schedule/domain/repositories/schedule_repository.dart';
import 'package:admin/shared/domain/providers/supabase_service_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'schedule_provider.g.dart';

@riverpod
ScheduleSupabaseDataSource scheduleDataSource(ScheduleDataSourceRef ref,
    {required SupabaseClient supabaseClient}) {
  return ScheduleSupabaseDataSource(supabaseClient);
}

@riverpod
ScheduleRepository scheduleRepository(ScheduleRepositoryRef ref) {
  final SupabaseClient supabaseClientService =
      ref.watch(supabaseServiceProvider);
  final ScheduleDataSource dataSource = ref
      .watch(scheduleDataSourceProvider(supabaseClient: supabaseClientService));
  return ScheduleRepositoryImpl(dataSource);
}
