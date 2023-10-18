import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.placeholder,
  });

  final TextEditingController? controller;
  final String? placeholder;

  @override
  Widget build(BuildContext context) {
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
