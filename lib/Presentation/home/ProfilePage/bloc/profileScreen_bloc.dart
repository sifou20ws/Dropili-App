import 'package:bloc/bloc.dart';
import 'package:dropili/domain/repositories/profile_repository.dart';
import 'package:equatable/equatable.dart';

import 'package:dropili/core/error/failure.dart';

part 'profileScreen_event.dart';
part 'profileScreen_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required ProfileRepository profilerepository})
      : _profilerepository = profilerepository,
        super(ProfileState()){
    on<EditButtonClickedEvent>(_editButtonClickedEvent);

  }
  ProfileRepository _profilerepository;

  void _editButtonClickedEvent(event, Emitter<ProfileState> emit){
    emit(state.copyWith(status: ProfileStatus.success));
  }

}


