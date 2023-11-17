import 'package:flutter/material.dart';

// ignore: constant_identifier_names
enum ButtonType { DEFAULT, TEXT, ICON }

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.buttonType,
    this.text,
    this.icon = Icons.abc,
  });

  final String? text;
  final Function()? onPressed;
  final ButtonType buttonType;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    switch (buttonType) {
      case ButtonType.TEXT:
        return TextButton(
          onPressed: onPressed,
          child: Text(text ?? ''),
        );
      case ButtonType.ICON:
        return IconButton(
          icon: Icon(icon),
          onPressed: onPressed,
        );
      default:
        return ElevatedButton(
          onPressed: onPressed,
          child: Text(text ?? ''),
        );
    }
  }
}
