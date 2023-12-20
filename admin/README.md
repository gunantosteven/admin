# admin

**(Still on Progress) It could be happened massive changes**

Flutter Stack:

- Project Architecture : Clean Architecture
- Project Structure : Features Based
- Database : Supabase
- Auth : Supabase
- State Management : Riverpod
- Route : auto_route
- Design System: WidgetBook
- Localization : flutter_localizations
- Unit Test: Mocktail
- Form Validation: formz

## How to run

Change env.example to env and change the data inside.

Uncomment this in pubspec.yaml

```yml
assets:
  - .env
```

then run flutter pub run build_runner watch --delete-conflicting-outputs

## Run build runner command

flutter pub run build_runner watch --delete-conflicting-outputs

## Run Widgetbook

bash flutter run -d macos -t lib/widgetbook/widgetbook.dart

## Using RiverPod State Management

https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/

## Reference Material 3 Adaptive Layout

- https://github.com/flutter/samples/tree/main/material_3_demo
- https://flutter.github.io/samples/web/material_3_demo/
- https://m3.material.io/develop/flutter

## Reference

- https://github.com/vhodiak/flutter_ddd_riverpod_example
- https://github.com/Uuttssaavv/flutter-clean-architecture-riverpod
- https://github.com/bizz84/complete-flutter-course
- https://medium.com/@mrijalulkahfi/form-validation-with-riverpod-formz-and-freezed-part-2-logic-29f45c677a11
