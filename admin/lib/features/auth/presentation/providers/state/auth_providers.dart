import 'package:admin/features/auth/domain/providers/auth_provider.dart';
import 'package:admin/features/auth/domain/repositories/auth_repository.dart';
import 'package:admin/features/auth/presentation/providers/state/auth_notifier.dart';
import 'package:admin/features/auth/presentation/providers/state/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authStateNotifierProvider =
    StateNotifierProvider.autoDispose<AuthNotifier, AuthState>(
  (ref) {
    final AuthRepository authRepository = ref.watch(authRepositoryProvider);
    return AuthNotifier(
      authRepository: authRepository,
    );
  },
);
