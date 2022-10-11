import 'package:formz/formz.dart';

enum UserNameValidatorError { empty, small }

class UserName extends FormzInput<String, UserNameValidatorError> {
  const UserName.pure() : super.pure('');

  const UserName.dirty([String value = '']) : super.dirty(value);

  @override
  UserNameValidatorError? validator(String? value) {
    return value?.trim().isNotEmpty == true
        ? ((value?.trim().length)! > 2)
            ? null
            : UserNameValidatorError.small
        : UserNameValidatorError.empty;
  }
}
