import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:supabase_flutter/supabase_flutter.dart';

final supabaseServiceProvider = riverpod.Provider<SupabaseClient>(
  (ref) {
    return Supabase.instance.client;
  },
);

final supabaseAuthServiceProvider = riverpod.Provider<GoTrueClient>(
  (ref) {
    return ref.watch(supabaseServiceProvider).auth;
  },
);
