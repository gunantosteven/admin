import 'package:admin/features/schedule/data/datasource/schedule_data_source.dart';
import 'package:admin/features/schedule/domain/providers/schedule_provider.dart';
import 'package:admin/features/schedule/domain/repositories/schedule_repository.dart';
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
  late dynamic scheduleDataSource;
  late dynamic scheduleRepository;

  setUpAll(
    () {
      scheduleDataSource = providerContainer.read(scheduleDataSourceProvider(
          supabaseClient: mockSupabaseClientService));
      scheduleRepository = providerContainer.read(scheduleRepositoryProvider);
    },
  );

  test('dataSourceProvider is a ScheduleDataSource', () {
    expect(
      scheduleDataSource,
      isA<ScheduleDataSource>(),
    );
  });
  test('scheduleRepositoryProvider is ScheduleRepository', () {
    expect(
      scheduleRepository,
      isA<ScheduleRepository>(),
    );
  });
}
