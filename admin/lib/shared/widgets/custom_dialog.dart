import 'package:admin/shared/theme/app_color.dart';
import 'package:flutter/material.dart';

// ignore: constant_identifier_names
enum DialogType { DEFAULT, REMOVE }

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.title,
    this.desc,
    required this.onConfirm,
    required this.dialogType,
  });

  final String title;
  final String? desc;
  final Function()? onConfirm;
  final DialogType dialogType;

  @override
  Widget build(BuildContext context) {
    switch (dialogType) {
      case DialogType.REMOVE:
        return AlertDialog(
          title: Text(title),
          content: desc != null ? Text(desc!) : null,
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FilledButton(
              onPressed: () {
                if (onConfirm != null) {
                  onConfirm!();
                }
                Navigator.of(context).pop();
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(AppColors.red),
                foregroundColor:
                    MaterialStatePropertyAll<Color>(AppColors.white),
              ),
              child: const Text('Remove'),
            ),
          ],
        );
      default:
        return AlertDialog(
          title: Text(title),
          content: desc != null ? Text(desc!) : null,
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FilledButton(
              onPressed: onConfirm,
              child: const Text('Remove'),
            ),
          ],
        );
    }
  }
}
