import 'package:admin/features/schedule/data/datasource/schedule_data_source.dart';
import 'package:admin/features/schedule/data/repositories/schedule_repository_impl.dart';
import 'package:admin/features/schedule/domain/repositories/schedule_repository.dart';
import 'package:admin/shared/domain/providers/supabase_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:supabase_flutter/supabase_flutter.dart';

final scheduleDataSourceProvider =
    riverpod.Provider.family<ScheduleDataSource, SupabaseClient>(
  (_, supabaseClient) => ScheduleSupabaseDataSource(supabaseClient),
);

final scheduleRepositoryProvider = riverpod.Provider<ScheduleRepository>(
  (ref) {
    final SupabaseClient supabaseClientService =
        ref.watch(supabaseServiceProvider);
    final ScheduleDataSource dataSource =
        ref.watch(scheduleDataSourceProvider(supabaseClientService));
    return ScheduleRepositoryImpl(dataSource);
  },
);
