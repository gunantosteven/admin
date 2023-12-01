import 'package:flutter/material.dart';

class SortDialog extends StatefulWidget {
  const SortDialog({
    super.key,
  });

  @override
  State<SortDialog> createState() => _SortDialogState();
}

class _SortDialogState extends State<SortDialog> {
  int selectedOption = 2;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Sorting by Created Date'),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        ListTile(
          title: const Text('Ascending'),
          leading: Radio(
            value: 1,
            groupValue: selectedOption,
            onChanged: (value) {
              setState(() {
                selectedOption = value!;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Descending'),
          leading: Radio(
            value: 2,
            groupValue: selectedOption,
            onChanged: (value) {
              setState(() {
                selectedOption = value!;
              });
            },
          ),
        ),
      ]),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FilledButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Sorting'),
        ),
      ],
    );
  }
}
