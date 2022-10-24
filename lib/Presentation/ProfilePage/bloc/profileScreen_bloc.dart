import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../domain/usecases/profileUsecase.dart';

part 'profileScreen_event.dart';
part 'profileScreen_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required ProfileUseCase profileUseCase})
      : _profileUseCase = profileUseCase,
        super(ProfileState()){
    on<EditButtonClickedEvent>(_editButtonClickedEvent);

  }
  ProfileUseCase _profileUseCase;

  void _editButtonClickedEvent(event, Emitter<ProfileState> emit){
    emit(state.copyWith(status: ProfileStatus.success));
  }

}


