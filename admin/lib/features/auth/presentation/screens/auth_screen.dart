import 'package:admin/features/auth/application/auth_controller.dart';
import 'package:admin/routes/app_route.dart';
import 'package:admin/shared/theme/app_padding.dart';
import 'package:admin/shared/theme/app_spacer.dart';
import 'package:admin/shared/widgets/custom_button.dart';
import 'package:admin/shared/widgets/custom_loading.dart';
import 'package:admin/shared/widgets/custom_snackbar.dart';
import 'package:admin/shared/widgets/custom_textfield.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class AuthScreen extends ConsumerStatefulWidget {
  static const routeName = '/auth';

  const AuthScreen({super.key});

  // * Keys for testing using find.byKey()
  static const loginButtonKey = Key('login-button');

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
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
    ref.listen<AsyncValue<bool?>>(authControllerProvider, (previous, next) {
      next.when(
          data: (data) {
            if (data == true) {
              if (ref.read(authControllerProvider.notifier).isAlreadyLogin()) {
                AutoRouter.of(context).replace(const DashboardRoute());
              } else {
                CustomSnackbar.show(
                    context: context,
                    type: ToastType.SUCCESS,
                    text: 'Check your email to login');
              }
            } else {
              CustomSnackbar.show(
                context: context,
                type: ToastType.ERROR,
                text: AppLocalizations.of(context)!.somethingWrong,
              );
            }
          },
          error: (o, s) {
            CustomSnackbar.show(
              context: context,
              type: ToastType.ERROR,
              text: o.toString(),
            );
          },
          loading: () {});
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppLocalizations.of(context)!.loginScreen),
      ),
      body: Stack(
        children: [
          Padding(
            padding: AppPadding.all24,
            child: Column(
              children: [
                CustomTextField(
                  textFieldType: TextFieldType.DEFAULT,
                  controller: emailController,
                  placeholder: AppLocalizations.of(context)!.email,
                ),
                AppSpacer.height24,
                CustomButton(
                  key: AuthScreen.loginButtonKey,
                  text: AppLocalizations.of(context)!.login,
                  buttonType: ButtonType.DEFAULT,
                  onPressed: () async {
                    ref.read(authControllerProvider.notifier).signInWithOtp(
                          email: emailController.text,
                        );
                  },
                ),
                AppSpacer.height24,
                CustomButton(
                  buttonType: ButtonType.DEFAULT,
                  text: AppLocalizations.of(context)!.anonymousLogin,
                  onPressed: () async {
                    // For Demo Purpose Only
                    // Will be deleted later
                    // Supabase not supported yet anonymous login
                    // https://github.com/supabase/gotrue/issues/68
                    ref
                        .read(authControllerProvider.notifier)
                        .signInWithPassword(
                            email: 'admin@ungapps.com', password: 'test123');
                  },
                ),
              ],
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              final state = ref.watch(authControllerProvider);

              return state.maybeWhen(
                  loading: () => const CustomLoading(),
                  orElse: () => Container());
            },
          ),
        ],
      ),
    );
  }
}
