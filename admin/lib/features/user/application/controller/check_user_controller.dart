import 'package:admin/features/user/domain/models/user_model.dart';
import 'package:admin/features/user/domain/providers/user_provider.dart';
import 'package:admin/shared/domain/providers/supabase_service_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'check_user_controller.g.dart';

///
@riverpod
class CheckUserController extends _$CheckUserController {
  @override
  FutureOr<void> build() async {
    return;
  }

  Future<void> checkUser() async {
    final supabaseAuthId =
        ref.read(supabaseAuthServiceProvider).currentUser?.id;
    if (supabaseAuthId != null) {
      final res =
          await ref.read(userRepositoryProvider).getUser(id: supabaseAuthId);
      // If user not exist, create new one
      if (res.isLeft()) {
        await ref.read(userRepositoryProvider).createUser(
              userModel: UserModel(
                  id: supabaseAuthId, name: '', authId: supabaseAuthId),
            );
      }
    }
  }
}
