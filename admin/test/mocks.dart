import 'package:admin/features/auth/data/datasource/auth_data_source.dart';
import 'package:admin/features/auth/domain/repositories/auth_repository.dart';
import 'package:admin/features/schedule/data/datasource/schedule_data_source.dart';
import 'package:admin/features/schedule/domain/repositories/schedule_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Services
class MockSupabaseService extends Mock implements SupabaseClient {}

class MockSupabaseAuthService extends Mock implements GoTrueClient {}

// Datasources
class MockAuthDataSource extends Mock implements AuthDataSource {}

class MockScheduleDataSource extends Mock implements ScheduleDataSource {}

// Repositories
class MockAuthRepository extends Mock implements AuthRepository {}

class MockScheduleRepository extends Mock implements ScheduleRepository {}

class Listener<T> extends Mock {
  void call(T? previous, T next);
}
