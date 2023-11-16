import 'package:admin/shared/theme/app_padding.dart';
import 'package:flutter/material.dart';

// ignore: constant_identifier_names
enum TextFieldType { DEFAULT, SEARCH }

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.placeholder,
    this.onChanged,
    required this.textFieldType,
  });

  final TextEditingController? controller;
  final String? placeholder;
  final ValueChanged<String>? onChanged;

  final TextFieldType textFieldType;

  @override
  Widget build(BuildContext context) {
    switch (textFieldType) {
      case TextFieldType.SEARCH:
        return TextField(
          key: key,
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: placeholder,
            contentPadding: AppPadding.horizontal24,
          ),
        );
      default:
        return TextField(
          key: key,
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: placeholder,
          ),
        );
    }
  }
}
