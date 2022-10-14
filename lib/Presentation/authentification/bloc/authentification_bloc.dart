import 'package:bloc/bloc.dart';
import 'package:dropili/domain/userRepository/userRepository.dart';
import 'package:equatable/equatable.dart';

part 'authentification_event.dart';
part 'authentification_state.dart';

class AuthentificationBloc
    extends Bloc<AuthentificationEvent, AuthentificationState> {
  final UserRepository userRepository;

  AuthentificationBloc({required UserRepository this.userRepository}) : super(AuthentificationInitial()) {
    on<AuthentificationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
