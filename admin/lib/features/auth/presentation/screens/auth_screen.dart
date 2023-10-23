import 'package:admin/features/auth/presentation/providers/state/auth_providers.dart';
import 'package:admin/features/auth/presentation/providers/state/auth_state.dart';
import 'package:admin/shared/theme/app_padding.dart';
import 'package:admin/shared/theme/app_spacer.dart';
import 'package:admin/shared/widgets/custom_button.dart';
import 'package:admin/shared/widgets/custom_snackbar.dart';
import 'package:admin/shared/widgets/custom_textfield.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class AuthScreen extends ConsumerStatefulWidget {
  static const routeName = '/AuthScreen';

  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<AuthScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      authStateNotifierProvider.select((value) => value),
      ((previous, next) {
        //show Snackbar on failure
        if (next is Failure) {
          CustomSnackbar.show(
              context: context,
              type: ToastType.ERROR,
              text: next.exception.message.toString());
        } else if (next is Success) {
          CustomSnackbar.show(
              context: context,
              type: ToastType.SUCCESS,
              text: 'Check your email to login');
        }
      }),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppLocalizations.of(context)!.loginScreen),
      ),
      body: Padding(
        padding: AppPadding.all24,
        child: Column(
          children: [
            CustomTextField(
              controller: emailController,
              placeholder: AppLocalizations.of(context)!.email,
            ),
            AppSpacer.height24,
            CustomButton(
              text: AppLocalizations.of(context)!.login,
              onPressed: () async {
                ref.read(authStateNotifierProvider.notifier).signInWithOtp(
                      email: emailController.text,
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
