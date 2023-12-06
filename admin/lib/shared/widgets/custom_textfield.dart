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
    this.onTap,
    this.readOnly = false,
    this.validator,
    required this.textFieldType,
  });

  final TextEditingController? controller;
  final String? placeholder;
  final ValueChanged<String>? onChanged;
  final Function()? onTap;
  final bool readOnly;
  final FormFieldValidator<String>? validator;

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
                    padding: AppPadding.right8,
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
          onTap: onTap,
          readOnly: readOnly,
        );
      default:
        return TextFormField(
          key: key,
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: placeholder,
          ),
          onTap: onTap,
          readOnly: readOnly,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          onChanged: onChanged,
        );
    }
  }
}
