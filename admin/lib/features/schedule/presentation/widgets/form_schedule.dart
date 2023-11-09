import 'package:admin/features/schedule/application/new_schedule_controller.dart';
import 'package:admin/shared/theme/app_padding.dart';
import 'package:admin/shared/theme/app_spacer.dart';
import 'package:admin/shared/widgets/custom_button.dart';
import 'package:admin/shared/widgets/custom_textfield.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FormSchedule extends ConsumerWidget {
  const FormSchedule({
    super.key,
    this.padding = AppPadding.all24,
    required this.jobController,
  });

  final EdgeInsetsGeometry padding;

  final TextEditingController jobController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: AppPadding.all24,
      child: Column(
        children: [
          CustomTextField(
            controller: jobController,
            placeholder: AppLocalizations.of(context)!.job,
          ),
          AppSpacer.height24,
          CustomButton(
            text: AppLocalizations.of(context)!.save,
            onPressed: () async {
              ref
                  .read(newScheduleControllerProvider.notifier)
                  .addSchedule(job: jobController.text);
            },
          ),
        ],
      ),
    );
  }
}
