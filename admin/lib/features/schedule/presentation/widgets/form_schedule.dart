import 'package:admin/shared/theme/app_padding.dart';
import 'package:admin/shared/theme/app_spacer.dart';
import 'package:admin/shared/widgets/custom_button.dart';
import 'package:admin/shared/widgets/custom_date.dart';
import 'package:admin/shared/widgets/custom_textfield.dart';
import 'package:admin/shared/widgets/custom_time.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FormSchedule extends ConsumerWidget {
  const FormSchedule({
    super.key,
    this.padding = AppPadding.all24,
    required this.titleController,
    required this.onConfirm,
  });

  final EdgeInsetsGeometry padding;

  final TextEditingController titleController;

  final Function()? onConfirm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: AppPadding.all24,
      child: Column(
        children: [
          CustomTextField(
            textFieldType: TextFieldType.DEFAULT,
            controller: titleController,
            placeholder: AppLocalizations.of(context)!.title,
          ),
          AppSpacer.height16,
          CustomDate(
            onSelectedDate: (date) {
              debugPrint(date.toString());
            },
          ),
          AppSpacer.height16,
          CustomTime(
            onSelectedTime: (time) {
              debugPrint(time.toString());
            },
          ),
          AppSpacer.height24,
          CustomButton(
            buttonType: ButtonType.DEFAULT,
            text: AppLocalizations.of(context)!.save,
            onPressed: onConfirm,
          ),
        ],
      ),
    );
  }
}
