import 'package:formz/formz.dart';

enum PhoneNumberValidationError { invalid }

class PhoneNumber extends FormzInput<String, PhoneNumberValidationError> {
  const PhoneNumber.pure([String value = '']) : super.pure(value);

  const PhoneNumber.dirty([String value = '']) : super.dirty(value);

  static final _phoneRegex = RegExp(
    r"^(05|06|07)[0-9]{8}$",
  );

  @override
  PhoneNumberValidationError? validator(String? value) {
    return _phoneRegex.hasMatch(value ?? '')
        ? null
        : PhoneNumberValidationError.invalid;
  }
}
