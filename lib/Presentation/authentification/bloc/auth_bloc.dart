import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dropili/core/api/google_auth_api.dart';
import 'package:dropili/core/error/failure.dart';
import 'package:dropili/core/utils/storage.dart';
import 'package:dropili/domain/repositories/auth_repository.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:local_auth/local_auth.dart';

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
    on<GoogleAuthEvent>(_googleAuthEvent);
    on<SignupSubmittingEvent>(_signupSubmittingEvent);
    on<RestoreSubmittingEvent>(_restorSubmittingEvent);
    on<BiometricsAuthentifactionEvent>(_biometricsAuthEvent);
    on<LogoutEvent>(_logoutEvent);
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
      await LocalStorageHandler.storeToken(token);
      await LocalStorageHandler.storeUser(
          state.usernameValue, state.passwordValue);

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

  void _googleAuthEvent(event, Emitter<AuthState> emit) async {
    final GoogleSignInAccount? account = await GoogleAuthApi.login();

    if (account == null) {
      emit(
        state.copyWith(
            status: Status.fail,
            errorExist: true,
            errorMessage: 'Something went wrong'),
      );
      return;
    }

    emit(state.copyWith(status: Status.loading));

    String token;

    try {
      log((await account.authentication).accessToken ?? 'nothing');

      token = await authRepository.googleLogin(
        name: account.displayName ?? ' ',
        email: account.email,
        access_token: (await account.authentication).accessToken,
      );

      await LocalStorageHandler.storeToken(token);

      emit(state.copyWith(status: Status.success));
    } on Failure catch (f) {
      emit(
        state.copyWith(
            status: Status.fail, errorExist: true, errorMessage: f.message),
      );
    } catch (e) {
      log(e.toString());
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

      if (resp) {
        add(LoginSubmittingEvent());
      }
    } on Failure catch (f) {
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
    if (!state.emailValid || state.emailValue.isEmpty) {
      state.copyWith(errorExist: true, errorMessage: 'Email can\'t be empty');
      return;
    }
    emit(state.copyWith(status: Status.loading));
    //here we post to api
    await Future.delayed(const Duration(seconds: 4));
    emit(state.copyWith(status: Status.success));
  }

  void _biometricsAuthEvent(event, Emitter<AuthState> emit) async {
    LocalAuthentication authentifier = LocalAuthentication();
    try {
      if (!await authentifier.canCheckBiometrics ||
          !await authentifier.isDeviceSupported()) {
        emit(
          state.copyWith(
              errorExist: true, errorMessage: 'Cannot use biometrics'),
        );
        return;
      }

      var biometrics = await authentifier.getAvailableBiometrics();
      if (biometrics.isEmpty) {
        emit(
          state.copyWith(
              errorExist: true, errorMessage: 'Cannot use biometrics'),
        );
        return;
      }

      bool authentified = await authentifier
          .authenticate(
        localizedReason: 'Use your biometrics to login',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      )
          .then((value) {
        return value;
      });

      if (!authentified) {
        return;
      }

      Map<String, String?> userData = await LocalStorageHandler.loadUser();
      if (userData['username'] == null || userData['password'] == null) {
        emit(
          state.copyWith(
              errorExist: true, errorMessage: 'No user is stored yet'),
        );
        return;
      }

      emit(
        state.copyWith(
            usernameValue: userData['username'],
            passwordValue: userData['password']),
      );

      add(LoginSubmittingEvent());
    } on PlatformException {
      emit(
        state.copyWith(
            errorExist: true,
            errorMessage: 'Your device doesn\'t support biometrics'),
      );
    }
  }

  void _logoutEvent(event, Emitter<AuthState> emit) async {
    await LocalStorageHandler.deleteToken();

    if (await GoogleAuthApi.isConnected()) {
      await GoogleAuthApi.signout();
    }

    log('loged out');
  }
}
