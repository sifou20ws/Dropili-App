part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class NameTextChangedEvent extends AuthEvent {
  final String name;

  NameTextChangedEvent(this.name);

  @override
  List<Object> get props => [name];
}

class UsernameChangedEvent extends AuthEvent {
  final String username;

  UsernameChangedEvent(this.username);

  @override
  List<Object> get props => [username];
}

class EmailTextChangeEvent extends AuthEvent {
  final String email;

  EmailTextChangeEvent(this.email);

  @override
  List<Object> get props => [email];
}

class PasswordTextChangeEvent extends AuthEvent {
  final String password;

  PasswordTextChangeEvent(this.password);

  @override
  List<Object> get props => [password];
}

class LoginSubmittingEvent extends AuthEvent {}

class SignupSubmittingEvent extends AuthEvent {}

class RestoreSubmittingEvent extends AuthEvent {}
