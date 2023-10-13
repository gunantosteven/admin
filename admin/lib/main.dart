import 'package:admin/app/app.dart';
import 'package:admin/app/app_env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() => mainCommon(AppEnvironment.PROD);

Future<void> mainCommon(AppEnvironment environment) async {
  WidgetsFlutterBinding.ensureInitialized();
  EnvInfo.initialize(environment);
  await Supabase.initialize(
    url: 'https://irtnunhqimnitwuyrjuv.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlydG51bmhxaW1uaXR3dXlyanV2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTcxNzg0ODcsImV4cCI6MjAxMjc1NDQ4N30.D13HiqywMzWsjd_L2Es4JRBr1NjammZ6p0xIilsVu-o',
  );
  runApp(ProviderScope(
    child: MyApp(),
  ));
}
