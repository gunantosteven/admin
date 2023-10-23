// ignore: constant_identifier_names
import 'package:admin/shared/theme/app_color.dart';
import 'package:flutter/material.dart';

// ignore: constant_identifier_names
enum ToastType { SUCCESS, ERROR }

class CustomSnackbar {
  static void show({required context, required ToastType type, required text}) {
    var textColor = AppColors.black;
    var backgroundColor = AppColors.white;

    switch (type) {
      case ToastType.SUCCESS:
        textColor = AppColors.white;
        backgroundColor = AppColors.green;
        break;
      case ToastType.ERROR:
        textColor = AppColors.white;
        backgroundColor = AppColors.red;
        break;
    }

    final snackBar = SnackBar(
      content: Text(
        text,
        style: TextStyle(color: textColor),
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
