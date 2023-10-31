import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'supabase_service_provider.g.dart';

@riverpod
SupabaseClient supabaseService(SupabaseServiceRef ref) {
  return Supabase.instance.client;
}

@riverpod
GoTrueClient supabaseAuthService(SupabaseAuthServiceRef ref) {
  return ref.watch(supabaseServiceProvider).auth;
}
