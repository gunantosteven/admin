import 'package:admin/features/schedule/domain/model/schedule_model.dart';
import 'package:admin/features/schedule/domain/providers/schedule_provider.dart';
import 'package:admin/shared/theme/app_padding.dart';
import 'package:admin/shared/theme/app_spacer.dart';
import 'package:admin/shared/widgets/custom_button.dart';
import 'package:admin/shared/widgets/custom_textfield.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class NewScheduleScreen extends ConsumerStatefulWidget {
  static const routeName = '/NewScheduleScreen';

  const NewScheduleScreen({super.key});

  @override
  ConsumerState<NewScheduleScreen> createState() => _NewScheduleScreenState();
}

class _NewScheduleScreenState extends ConsumerState<NewScheduleScreen> {
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
              onPressed: () async {
                ref
                    .read(scheduleRepositoryProvider)
                    .addSchedule(
                      scheduleModel: ScheduleModel(
                          id: '3dc7f2e8-d14d-4449-af1c-9c77b04261ca',
                          job: jobController.text),
                    )
                    .then((value) => value.fold(
                        (l) => debugPrint(l.identifier), (r) => null));
              },
            ),
          ],
        ),
      ),
    );
  }
}
