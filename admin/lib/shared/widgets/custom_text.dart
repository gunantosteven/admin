import 'package:admin/shared/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

// ignore: constant_identifier_names
enum TextType { H1, H2, H3, H4, BODY }

class CustomText extends StatelessWidget {
  const CustomText(
    this.text, {
    super.key,
    required this.textType,
  });

  final String text;
  final TextType textType;

  @override
  Widget build(BuildContext context) {
    switch (textType) {
      case TextType.H1:
        return Text(
          text,
          style: AppTextStyles.h1,
        );
      case TextType.H2:
        return Text(
          text,
          style: AppTextStyles.h2,
        );
      case TextType.H3:
        return Text(
          text,
          style: AppTextStyles.h3,
        );
      case TextType.H4:
        return Text(
          text,
          style: AppTextStyles.h4,
        );
      case TextType.BODY:
        return Text(
          text,
          style: AppTextStyles.body,
        );
      default:
        return Text(
          text,
        );
    }
  }
}
