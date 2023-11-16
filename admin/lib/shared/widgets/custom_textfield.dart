import 'package:admin/shared/theme/app_color.dart';
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
          maxLines: 1,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            hintText: placeholder,
            contentPadding: AppPadding.all16,
            isDense: true,
            suffixIcon: controller != null && controller!.text.isEmpty
                ? null
                : Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        controller?.clear();
                        if (onChanged != null) {
                          onChanged!('');
                        }
                      },
                    ),
                  ),
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
