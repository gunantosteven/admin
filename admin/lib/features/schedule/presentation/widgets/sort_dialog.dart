import 'package:admin/features/schedule/application/sort_schedule_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SortDialog extends ConsumerStatefulWidget {
  const SortDialog({
    super.key,
  });

  @override
  ConsumerState<SortDialog> createState() => _SortDialogState();
}

class _SortDialogState extends ConsumerState<SortDialog> {
  int selectedOption = 1;

  @override
  void initState() {
    selectedOption = ref.read(sortScheduleControllerProvider).value! ? 1 : 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Sort by Date'),
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
            ref
                .read(sortScheduleControllerProvider.notifier)
                .sortSchedule(selectedOption == 1);
          },
          child: const Text('Sort'),
        ),
      ],
    );
  }
}
