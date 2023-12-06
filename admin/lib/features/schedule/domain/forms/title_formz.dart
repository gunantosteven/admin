import 'package:formz/formz.dart';

enum TitleValidationError {
  empty,
  invalid,
  ;

  String getMessage() {
    switch (this) {
      case empty:
        return 'Title can\'t be empty';
      case invalid:
        return 'Minimum 5 letters';
    }
  }
}

class TitleFormz extends FormzInput<String, TitleValidationError> {
  const TitleFormz.pure() : super.pure('');

  const TitleFormz.dirty(String value) : super.dirty(value);

  @override
  TitleValidationError? validator(String value) {
    if (value.isEmpty) return TitleValidationError.empty;

    if (value.length < 5) {
      return TitleValidationError.invalid;
    }

    return null;
  }
}
