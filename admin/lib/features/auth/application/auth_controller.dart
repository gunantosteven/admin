import 'package:admin/features/auth/domain/providers/auth_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<bool> build() {
    return false;
  }

  Future<void> signInWithOtp({required String email}) async {
    state = const AsyncValue.loading();
    final authRepo = ref.read(authRepositoryProvider);
    final response = await authRepo.signInWithOtp(email: email);

    state = await response.fold(
        (failure) => AsyncValue<bool>.error(
            failure.message.toString(), StackTrace.current),
        (success) => AsyncValue.data(success));
  }
}
