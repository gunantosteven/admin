import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockSupabaseService extends Mock implements SupabaseClient {}

class MockSupabaseAuthService extends Mock implements GoTrueClient {}
