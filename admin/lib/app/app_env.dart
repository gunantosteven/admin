import 'package:flutter_dotenv/flutter_dotenv.dart';

// ignore: constant_identifier_names
enum AppEnvironment { DEV, STAGING, PROD }

abstract class EnvInfo {
  static AppEnvironment _environment = AppEnvironment.DEV;

  static void initialize(AppEnvironment environment) {
    EnvInfo._environment = environment;
  }

  static String get appName => _environment._appTitle;
  static String get envName => _environment._envName;
  static String get connectionString => _environment._connectionString;
  static String get supabaseString => _environment._supabaseUrl;
  static String get supabaseAnonKey => _environment._supabaseAnonKey;
  static AppEnvironment get environment => _environment;
  static bool get isProduction => _environment == AppEnvironment.PROD;
}

extension _EnvProperties on AppEnvironment {
  static const _appTitles = {
    AppEnvironment.DEV: 'Q Flutter TDD Dev',
    AppEnvironment.STAGING: 'Q Flutter TDD Staging',
    AppEnvironment.PROD: 'Q Flutter TDD',
  };

  static const _connectionStrings = {
    AppEnvironment.DEV: 'https://api.spoonacular.com',
    AppEnvironment.STAGING: 'https://api.spoonacular.com',
    AppEnvironment.PROD: 'https://api.spoonacular.com',
  };

  static const _envs = {
    AppEnvironment.DEV: 'dev',
    AppEnvironment.STAGING: 'staging',
    AppEnvironment.PROD: 'prod',
  };

  static final _supabaseUrls = {
    AppEnvironment.DEV: dotenv.get('SUPABASE_URL'),
    AppEnvironment.STAGING: dotenv.get('SUPABASE_URL'),
    AppEnvironment.PROD: dotenv.get('SUPABASE_URL'),
  };

  static final _supabaseAnonKeys = {
    AppEnvironment.DEV: dotenv.get('SUPABASE_ANON_KEY'),
    AppEnvironment.STAGING: dotenv.get('SUPABASE_ANON_KEY'),
    AppEnvironment.PROD: dotenv.get('SUPABASE_ANON_KEY'),
  };

  String get _appTitle => _appTitles[this]!;
  String get _envName => _envs[this]!;
  String get _connectionString => _connectionStrings[this]!;
  String get _supabaseUrl => _supabaseUrls[this]!;
  String get _supabaseAnonKey => _supabaseAnonKeys[this]!;
}
