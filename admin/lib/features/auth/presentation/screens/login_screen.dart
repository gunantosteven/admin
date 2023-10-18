import 'package:admin/features/auth/presentation/providers/state/auth_providers.dart';
import 'package:admin/shared/theme/app_padding.dart';
import 'package:admin/shared/theme/app_spacer.dart';
import 'package:admin/shared/widgets/custom_button.dart';
import 'package:admin/shared/widgets/custom_textfield.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/RegisterScreen';

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _NewScheduleScreenState();
}

class _NewScheduleScreenState extends ConsumerState<LoginScreen> {
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
                ref
                    .read(authStateNotifierProvider.notifier)
                    .signInWithOtp(email: emailController.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
