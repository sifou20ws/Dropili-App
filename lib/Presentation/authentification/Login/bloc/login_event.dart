part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class EmailTextChangeEvent extends LoginEvent {
  final String email;

  EmailTextChangeEvent(this.email);

  @override
  List<Object> get props => [email];
}

class PasswordTextChangeEvent extends LoginEvent {
  final String password;

  PasswordTextChangeEvent(this.password);

  @override
  List<Object> get props => [password];
}

class SubmittingEvent extends LoginEvent {
  // final String email;
  // final String password;

  // SubmittingEvent(this.email, this.password);
}
