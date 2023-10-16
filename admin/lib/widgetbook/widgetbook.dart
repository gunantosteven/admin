// widgetbook.dart

import 'package:admin/shared/theme/app_color.dart';
import 'package:admin/shared/theme/app_padding.dart';
import 'package:admin/shared/widgets/custom_button.dart';
import 'package:admin/shared/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// Import the generated directories variable
import 'widgetbook.directories.g.dart';

void main() {
// ignore: missing_provider_scope
  runApp(const WidgetbookApp());
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      // Use the generated directories variable
      directories: directories,
      addons: [],
    );
  }
}

Widget _container({required child}) {
  return Center(
    child: Container(
      color: AppColors.white,
      padding: AppPadding.all24,
      child: child,
    ),
  );
}

// CustomButton
@widgetbook.UseCase(
  name: 'Custom Button',
  type: CustomButton,
)
Widget customButtonUseCase(BuildContext context) {
  return _container(
    child: CustomButton(
      text: context.knobs.string(
        label: 'Title Button',
        initialValue: 'Custom Button',
      ),
      onPressed: () {
        debugPrint('onPressed');
      },
    ),
  );
}

// CustomTextField
@widgetbook.UseCase(
  name: 'Custom Textfield',
  type: CustomTextField,
)
Widget customTextFieldUseCase(BuildContext context) {
  final controller = TextEditingController(
    text: context.knobs.string(
      label: 'Textfield Text',
      initialValue: 'Custom Textfield',
    ),
  );
  return _container(
    child: CustomTextField(
      controller: controller,
    ),
  );
}
