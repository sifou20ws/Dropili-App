import 'package:formz/formz.dart';

enum PasswordValidationError { empty, small }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');

  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String? value) {
    return value?.trim().isNotEmpty == true
        ? ((value?.trim().length)! > 7)
            ? null
            : PasswordValidationError.small
        : PasswordValidationError.empty;
  }
}
