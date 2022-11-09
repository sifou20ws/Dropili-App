import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dropili/core/error/failure.dart';
import 'package:dropili/core/utils/token.dart';
import 'package:dropili/domain/repositories/auth_repository.dart';
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
    on<PasswordVisibiltyChangeEvent>(_passwordVisiblityChangeEvent);
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
    if (event.username.length <= 3 || event.username.toString().contains(' ')) {
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
    if (event.password.length < 8) {
      emit(state.copyWith(passwordValid: false));
    } else {
      emit(state.copyWith(passwordValid: true));
    }
  }

  void _passwordVisiblityChangeEvent(event, Emitter<AuthState> emit) {
    emit(state.copyWith(passwordVisible: event.visibility));
  }

  void _loginSubmittingEvent(event, Emitter<AuthState> emit) async {
    if (state.usernameValue.isEmpty || state.passwordValue.isEmpty) {
      emit(state.copyWith(status: Status.init));
      emit(state.copyWith(
        status: Status.fail,
        errorExist: true,
        errorMessage: 'Empty email or password fields',
      ));
      return;
    }

    emit(state.copyWith(status: Status.loading));

    String token;

    try {
      token = await authRepository.loginUser(
          username: state.usernameValue, password: state.passwordValue);
      await TokenHandler.storeToken(token);
      await TokenHandler.storeUser(state.usernameValue, state.passwordValue);

      emit(state.copyWith(status: Status.success));
    } on Failure catch (f) {
      log(f.message);
      emit(
        state.copyWith(
            status: Status.fail, errorExist: true, errorMessage: f.message),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.fail,
          errorExist: true,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _signupSubmittingEvent(event, Emitter<AuthState> emit) async {
    if (!(state.emailValid &&
        state.passwordValid &&
        state.nameValid &&
        state.usernameValid)) {
      return;
    }

    if (state.emailValue.isEmpty ||
        state.passwordValue.isEmpty ||
        state.nameValue.isEmpty ||
        state.usernameValue.isEmpty) {
      emit(
        state.copyWith(
            status: Status.fail,
            errorExist: true,
            errorMessage: 'All fields must be filled'),
      );
      return;
    }

    emit(state.copyWith(status: Status.loading));
    bool resp;
    try {
      resp = await authRepository.signupUser(
        email: state.emailValue,
        password: state.passwordValue,
        name: state.nameValue,
        username: state.usernameValue,
      );

      // log(resp.toString());

      if (resp) {
        add(LoginSubmittingEvent());
        // emit(state.copyWith(status: Status.success));
      }
    } on Failure catch (f) {
      // log(f.message);
      emit(
        state.copyWith(
            status: Status.fail, errorExist: true, errorMessage: f.message),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.fail,
          errorExist: true,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _restorSubmittingEvent(event, Emitter<AuthState> emit) async {
    if (!state.emailValid) {
      return;
    }
    emit(state.copyWith(status: Status.loading));
    //here we post to api
    await Future.delayed(const Duration(seconds: 4));
    emit(state.copyWith(status: Status.success));
  }
}
