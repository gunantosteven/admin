import 'package:admin/features/schedule/domain/models/schedule_model.dart';
import 'package:admin/shared/theme/app_padding.dart';
import 'package:admin/shared/theme/app_spacer.dart';
import 'package:admin/shared/widgets/custom_button.dart';
import 'package:admin/shared/widgets/custom_date.dart';
import 'package:admin/shared/widgets/custom_textfield.dart';
import 'package:admin/shared/widgets/custom_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FormSchedule extends ConsumerStatefulWidget {
  const FormSchedule({
    super.key,
    this.padding = AppPadding.all24,
    this.scheduleModel,
    this.onChangedTitle,
    this.titleValidator,
    this.enabledButton = true,
    required this.titleController,
    required this.onConfirm,
  });

  final EdgeInsetsGeometry padding;

  final ScheduleModel? scheduleModel;

  final ValueChanged<String>? onChangedTitle;

  final FormFieldValidator<String>? titleValidator;

  final bool enabledButton;

  final TextEditingController titleController;

  final Function(DateTime date, TimeOfDay time)? onConfirm;

  @override
  ConsumerState<FormSchedule> createState() => _FormScheduleState();
}

class _FormScheduleState extends ConsumerState<FormSchedule> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  void initState() {
    final scheduleDate = widget.scheduleModel?.date;
    if (scheduleDate != null) {
      selectedDate = scheduleDate;
      selectedTime =
          TimeOfDay(hour: scheduleDate.hour, minute: scheduleDate.minute);
    } else {
      selectedDate = DateTime.now();
      selectedTime = const TimeOfDay(hour: 0, minute: 0);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.all24,
      child: Column(
        children: [
          CustomTextField(
            textFieldType: TextFieldType.DEFAULT,
            controller: widget.titleController,
            placeholder: AppLocalizations.of(context)!.title,
            onChanged: widget.onChangedTitle,
            validator: widget.titleValidator,
          ),
          AppSpacer.height16,
          CustomDate(
            initialDate: selectedDate,
            onSelectedDate: (date) {
              selectedDate = date;
              debugPrint(date.toString());
            },
          ),
          AppSpacer.height16,
          CustomTime(
            initialTime: selectedTime,
            onSelectedTime: (time) {
              selectedTime = time;
              debugPrint(time.toString());
            },
          ),
          AppSpacer.height24,
          CustomButton(
            buttonType: ButtonType.DEFAULT,
            text: AppLocalizations.of(context)!.save,
            onPressed: !widget.enabledButton
                ? null
                : () {
                    if (widget.onConfirm != null &&
                        selectedDate != null &&
                        selectedTime != null) {
                      widget.onConfirm!(selectedDate!, selectedTime!);
                    }
                  },
          ),
        ],
      ),
    );
  }
}
