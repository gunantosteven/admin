import 'package:admin/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin/features/auth/presentation/providers/state/auth_state.dart'
    as auth_state;

class AuthNotifier extends StateNotifier<auth_state.AuthState> {
  final AuthRepository authRepository;

  AuthNotifier({
    required this.authRepository,
  }) : super(const auth_state.AuthState.initial());

  Future<void> signUp({required String email, required String password}) async {
    state = const auth_state.AuthState.loading();
    final response = await authRepository.signUp(
      email: email,
      password: password,
    );

    state = await response.fold(
        (failure) => auth_state.AuthState.failure(failure),
        (success) => const auth_state.AuthState.success());
  }

  Future<void> signInWithOtp({required String email}) async {
    state = const auth_state.AuthState.loading();
    final response = await authRepository.signInWithOtp(email: email);

    state = await response.fold(
        (failure) => auth_state.AuthState.failure(failure),
        (success) => const auth_state.AuthState.success());
  }

  Future<void> signInWithPassword(
      {required String email, required String password}) async {
    state = const auth_state.AuthState.loading();
    final response = await authRepository.signInWithPassword(
      email: email,
      password: password,
    );

    state = await response.fold(
        (failure) => auth_state.AuthState.failure(failure),
        (success) => const auth_state.AuthState.success());
  }
}
