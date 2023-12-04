import 'package:admin/shared/extension/date_extension.dart';
import 'package:admin/shared/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class CustomDate extends StatefulWidget {
  const CustomDate({
    super.key,
    this.initialDate,
    required this.onSelectedDate,
  });

  final Function(DateTime dateTime) onSelectedDate;

  final DateTime? initialDate;

  @override
  State<CustomDate> createState() => _CustomDateState();
}

class _CustomDateState extends State<CustomDate> {
  final dateNow = DateTime.now();

  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    textEditingController.text = textEditingController.text =
        dateNow.string(DateType.dayOfWeekDate).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: textEditingController,
      textFieldType: TextFieldType.DEFAULT,
      readOnly: true,
      placeholder: 'Date',
      onTap: () {
        showDatePicker(
            context: context,
            initialDate: widget.initialDate ?? dateNow,
            firstDate: dateNow,
            lastDate: DateTime(dateNow.year + 3, dateNow.month, dateNow.day),
            builder: (context, picker) {
              return Theme(
                data: ThemeData(),
                child: picker!,
              );
            }).then((selectedDate) {
          if (selectedDate != null) {
            textEditingController.text =
                selectedDate.string(DateType.dayOfWeekDate).toString();
            widget.onSelectedDate(selectedDate);
          }
        });
      },
    );
  }
}
