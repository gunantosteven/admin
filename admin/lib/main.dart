import 'package:admin/app/app.dart';
import 'package:admin/app/app_env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() => mainCommon(AppEnvironment.PROD);

Future<void> mainCommon(AppEnvironment environment) async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "envoriment/env");
  EnvInfo.initialize(environment);
  await Supabase.initialize(
    url: EnvInfo.supabaseString,
    anonKey: EnvInfo.supabaseAnonKey,
  );
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}
