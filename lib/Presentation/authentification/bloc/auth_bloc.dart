import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dropili/core/api/post_get.dart';
import 'package:dropili/core/error/failure.dart';
import 'package:dropili/domain/userRepository/auth_repository.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc(this.authRepository) : super(AuthState()) {
    on<NameTextChangedEvent>(_nameTextChangedEvent);
    on<UsernameChangedEvent>(_usernameTextChangedEvent);
    on<EmailTextChangeEvent>(_emailTextChangeEvent);
    on<PasswordTextChangeEvent>(_passwordTextChangeEvent);
    //for restoring password
    on<LoginSubmittingEvent>(_loginSubmittingEvent);
    on<SignupSubmittingEvent>(_signupSubmittingEvent);
    on<RestoreSubmittingEvent>(_restorSubmittingEvent);
  }

  void _nameTextChangedEvent(event, Emitter<AuthState> emit) {
    emit(state.copyWith(nameValue: event.name));
    if (event.name.length <= 3) {
      emit(state.copyWith(nameValid: false));
    } else {
      emit(state.copyWith(nameValid: true));
    }
  }

  void _usernameTextChangedEvent(event, Emitter<AuthState> emit) {
    emit(state.copyWith(usernameValue: event.username));
    if (event.username.length <= 0) {
      emit(state.copyWith(usernameValid: false));
    } else {
      emit(state.copyWith(usernameValid: true));
    }
  }

  void _emailTextChangeEvent(event, Emitter<AuthState> emit) {
    emit(state.copyWith(emailValue: event.email));

    if (!EmailValidator.validate(event.email)) {
      emit(state.copyWith(emailValid: false));
    } else {
      emit(state.copyWith(emailValid: true));
    }
  }

  void _passwordTextChangeEvent(event, Emitter<AuthState> emit) {
    emit(state.copyWith(passwordValue: event.password));
    if (event.password.length <= 8) {
      emit(state.copyWith(passwordValid: false));
    } else {
      emit(state.copyWith(passwordValid: true));
    }
  }

  void _loginSubmittingEvent(event, Emitter<AuthState> emit) async {
    if (!(state.usernameValid && state.passwordValid)) {
      return;
    }

    emit(state.copyWith(status: Status.loading));
    try {
      Network().post('/token', {
        'username': state.usernameValue,
        'password': state.passwordValue,
        'device_name': 'poco'
      });
      // authRepository.loginUser(
      //     username: state.usernameValue, password: state.passwordValue);
    } on Exception catch (f) {
      emit(state.copyWith(
          status: Status.fail, errorExist: true, errorMessage: f.toString()));
    }

    await Future.delayed(const Duration(seconds: 4));
    emit(state.copyWith(
        status: Status.fail, errorExist: true, errorMessage: ''));
    // emit(state.copyWith(status: Status.success));
  }

  void _signupSubmittingEvent(event, Emitter<AuthState> emit) async {
    if (!(state.emailValid &&
        state.passwordValid &&
        state.nameValid &&
        state.usernameValid)) {
      return;
    }

    log(state.emailValue);

    emit(state.copyWith(status: Status.loading));
    await Future.delayed(const Duration(seconds: 4));
    emit(state.copyWith(
        status: Status.fail,
        errorExist: true,
        errorMessage: 'The is no response from server (404)'));
    // emit(state.copyWith(status: Status.success));
  }

  void _restorSubmittingEvent(event, Emitter<AuthState> emit) async {
    if (!state.emailValid) {
      return;
    }
    emit(state.copyWith(status: Status.loading));
    await Future.delayed(const Duration(seconds: 4));
    emit(state.copyWith(
        status: Status.fail,
        errorExist: true,
        errorMessage: 'something is wrong'));
  }
}
