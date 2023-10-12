// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:admin/widgetbook/widgetbook.dart' as _i2;
import 'package:widgetbook/widgetbook.dart' as _i1;

final directories = <_i1.WidgetbookNode>[
  _i1.WidgetbookFolder(
    name: 'shared',
    children: [
      _i1.WidgetbookFolder(
        name: 'widgets',
        children: [
          _i1.WidgetbookComponent(
            name: 'CustomButton',
            useCases: [
              _i1.WidgetbookUseCase(
                name: 'Custom Button',
                builder: _i2.customButtonUseCase,
              )
            ],
          ),
          _i1.WidgetbookComponent(
            name: 'CustomTextField',
            useCases: [
              _i1.WidgetbookUseCase(
                name: 'Custom Textfield',
                builder: _i2.customTextFieldUseCase,
              )
            ],
          ),
        ],
      )
    ],
  )
];
