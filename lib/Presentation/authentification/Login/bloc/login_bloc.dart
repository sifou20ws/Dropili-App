import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<SubmittingEvent>(_submittingEvent);
    on<EmailTextChangeEvent>(_emailTextChangeEvent);
    on<PasswordTextChangeEvent>(_passwordTextChangeEvent);
  }

  void _emailTextChangeEvent(event, Emitter<LoginState> emit) {
    emit(state.copyWith(emailValue: event.email));

    if (!EmailValidator.validate(event.email)) {
      emit(state.copyWith(emailValid: false));
    } else {
      emit(state.copyWith(emailValid: true));
    }
  }

  void _passwordTextChangeEvent(event, Emitter<LoginState> emit) {
    emit(state.copyWith(passwordValue: event.password));
    if (event.password.length <= 8) {
      emit(state.copyWith(passwordValid: false));
    } else {
      emit(state.copyWith(passwordValid: true));
    }
  }

  void _submittingEvent(event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: Status.loading));
    await Future.delayed(const Duration(seconds: 4));
    emit(state.copyWith(
        status: Status.fail,
        errorExist: true,
        errorMessage: 'The is no response from server (404)'));
    // emit(state.copyWith(status: Status.success));
  }
}
