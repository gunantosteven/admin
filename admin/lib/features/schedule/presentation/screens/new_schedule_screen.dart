import 'package:admin/shared/theme/padding.dart';
import 'package:admin/shared/theme/spacer.dart';
import 'package:admin/shared/widgets/custom_button.dart';
import 'package:admin/shared/widgets/custom_textfield.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class NewScheduleScreen extends StatefulWidget {
  static const routeName = '/NewScheduleScreen';

  const NewScheduleScreen({super.key});

  @override
  State<NewScheduleScreen> createState() => _NewScheduleScreenState();
}

class _NewScheduleScreenState extends State<NewScheduleScreen> {
  final TextEditingController jobController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    jobController.text = AppLocalizations.of(context)!.job;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppLocalizations.of(context)!.newSchedule),
      ),
      body: Padding(
        padding: AppPadding.all24,
        child: Column(
          children: [
            CustomTextField(
              controller: jobController,
            ),
            AppSpacer.height24,
            CustomButton(
              text: AppLocalizations.of(context)!.save,
              onPressed: () => {},
            ),
          ],
        ),
      ),
    );
  }
}
