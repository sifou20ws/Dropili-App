part of 'login_bloc.dart';

enum Status { init, loading, success, fail, finish }

class LoginState extends Equatable {
  const LoginState(
      {this.emailValue = '',
      this.passwordValue = '',
      this.emailValid = true,
      this.passwordValid = true,
      this.errorExist = false,
      this.errorMessage = '',
      this.status = Status.init});

  final String emailValue;
  final String passwordValue;

  final bool emailValid;
  final bool passwordValid;

  final bool errorExist;
  final String errorMessage;
  final Status status;

  LoginState copyWith(
      {String? emailValue,
      String? passwordValue,
      bool? emailValid,
      bool? passwordValid,
      bool? errorExist,
      String? errorMessage,
      Status? status}) {
    return LoginState(
        emailValue: emailValue ?? this.emailValue,
        passwordValue: passwordValue ?? this.passwordValue,
        emailValid: emailValid ?? this.emailValid,
        passwordValid: passwordValid ?? this.passwordValid,
        errorExist: errorExist ?? this.errorExist,
        errorMessage: errorMessage ?? this.errorMessage,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [emailValid, passwordValid, status];
}
