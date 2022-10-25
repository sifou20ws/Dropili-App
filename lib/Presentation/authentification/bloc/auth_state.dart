part of 'auth_bloc.dart';

enum Status { init, loading, success, fail, finish }

class AuthState extends Equatable {
  const AuthState(
      {this.nameValue = '',
      this.usernameValue = '',
      this.emailValue = '',
      this.passwordValue = '',
      this.errorMessage = '',
      this.nameValid = true,
      this.usernameValid = true,
      this.emailValid = true,
      this.passwordValid = true,
      this.passwordVisible = false,
      this.errorExist = false,
      this.status = Status.init});

  final String nameValue;
  final String usernameValue;
  final String emailValue;
  final String passwordValue;

  final bool nameValid;
  final bool usernameValid;
  final bool emailValid;
  final bool passwordValid;
  final bool passwordVisible;

  final bool errorExist;
  final String errorMessage;
  final Status status;

  AuthState copyWith(
      {String? nameValue,
      String? usernameValue,
      String? emailValue,
      String? passwordValue,
      bool? nameValid,
      bool? usernameValid,
      bool? emailValid,
      bool? passwordValid,
      bool? passwordVisible,
      bool? errorExist,
      String? errorMessage,
      Status? status}) {
    return AuthState(
        nameValue: nameValue ?? this.nameValue,
        usernameValue: usernameValue ?? this.usernameValue,
        emailValue: emailValue ?? this.emailValue,
        passwordValue: passwordValue ?? this.passwordValue,
        nameValid: nameValid ?? this.nameValid,
        usernameValid: usernameValid ?? this.usernameValid,
        emailValid: emailValid ?? this.emailValid,
        passwordValid: passwordValid ?? this.passwordValid,
        passwordVisible: passwordVisible ?? this.passwordVisible,
        errorExist: errorExist ?? this.errorExist,
        errorMessage: errorMessage ?? this.errorMessage,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [
        nameValue,
        usernameValue,
        emailValue,
        passwordValue,
        nameValid,
        usernameValid,
        emailValid,
        passwordValid,
        passwordVisible,
        status
      ];
}
