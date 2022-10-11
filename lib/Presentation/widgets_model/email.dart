import 'package:formz/formz.dart';

enum EmailValidationError { invalid }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure([String value = '']) : super.pure(value);

  const Email.dirty([String value = '']) : super.dirty(value);

  static final _EmailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  @override
  EmailValidationError? validator(String? value) {
    return _EmailRegex.hasMatch(value ?? '') || value!.trim().isEmpty
        ? null
        : EmailValidationError.invalid;
  }
}
