import 'package:admin/shared/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class CustomTime extends StatefulWidget {
  const CustomTime({
    super.key,
    this.initialTime = const TimeOfDay(hour: 0, minute: 0),
    required this.onSelectedTime,
  });

  final Function(TimeOfDay dateTime) onSelectedTime;

  final TimeOfDay? initialTime;

  @override
  State<CustomTime> createState() => _CustomTimeState();
}

class _CustomTimeState extends State<CustomTime> {
  final timeNow = TimeOfDay.now();

  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    textEditingController.text = formatTime(widget.initialTime ?? timeNow);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: textEditingController,
      textFieldType: TextFieldType.DEFAULT,
      readOnly: true,
      placeholder: 'Time',
      onTap: () {
        showTimePicker(
          context: context,
          initialTime: widget.initialTime ?? TimeOfDay.now(),
          builder: (BuildContext context, Widget? child) {
            return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child ?? Container(),
            );
          },
        ).then((selectedTime) {
          if (selectedTime != null) {
            textEditingController.text = formatTime(selectedTime);
            widget.onSelectedTime(selectedTime);
          }
        });
      },
    );
  }

  String formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
