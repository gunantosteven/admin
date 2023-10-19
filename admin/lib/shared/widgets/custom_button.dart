import 'package:flutter/material.dart';

// ignore: constant_identifier_names
enum ButtonType { DEFAULT, TEXT }

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.buttonType = ButtonType.DEFAULT,
  });

  final String text;
  final Function()? onPressed;
  final ButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    switch (buttonType) {
      case ButtonType.TEXT:
        return TextButton(
          onPressed: onPressed,
          child: Text(text),
        );
      default:
        return ElevatedButton(
          onPressed: onPressed,
          child: Text(text),
        );
    }
  }
}
