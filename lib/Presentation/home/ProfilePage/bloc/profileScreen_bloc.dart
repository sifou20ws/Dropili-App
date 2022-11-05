import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dropili/data/models/get_blocks_model.dart';
import 'package:dropili/data/models/post_user_profile_response.dart';
import 'package:dropili/domain/repositories/edit_profile_repository.dart';
import 'package:equatable/equatable.dart';

import 'package:dropili/core/error/failure.dart';

part 'profileScreen_event.dart';
part 'profileScreen_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  EditProfileRepository _editProfileRepository;
  ProfileBloc({required EditProfileRepository editProfilerepository})
      : _editProfileRepository = editProfilerepository,
        super(ProfileState(userBlocks: [])){
    on<EditButtonClickedEvent>(_editButtonClickedEvent);
    on<GetUserBlocksEvent> (_getUserBlocksEvent);
    on<GetProfileEvent>(_getProfileEvent);
    on<DeleteUserBlocksEvent>(_deleteUserBlocksEvent);
  }

  void _editButtonClickedEvent(event, Emitter<ProfileState> emit){
    emit(state.copyWith(status: ProfileStatus.success));
  }

  void _getUserBlocksEvent(event, Emitter<ProfileState> emit) async{
    emit(state.copyWith(status: ProfileStatus.loading));
    List<UserBlocksItem> resp;
    try{
      resp = await  _editProfileRepository.getUserBlocks();
      emit(state.copyWith(status: ProfileStatus.getSuccess));
      emit(state.copyWith(userBlocks: resp ));
      log(resp.toString() , name: 'user blocks');
    }catch(e){
      emit(state.copyWith(status: ProfileStatus.fail));
      log(('errorr :'));
      log(e.toString());
    }
  }

  void _getProfileEvent(GetProfileEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    var resp;
    try {
      resp = await _editProfileRepository.getProfileShow();
      emit(state.copyWith(status: ProfileStatus.getSuccess));
      emit(state.copyWith(showProfile: resp));
      //log(resp.toString());
    } catch (e) {
      emit(state.copyWith(status: ProfileStatus.fail));
      log(('error :'));
      log(e.toString());
    }
  }

  void _deleteUserBlocksEvent(DeleteUserBlocksEvent event, Emitter<ProfileState> emit) async{
    //emit(state.copyWith(status: ProfileStatus.loading));
    var resp;
    try{
      resp = await  _editProfileRepository.deleteBlocks(event.id);
      //emit(state.copyWith(status: ProfileStatus.getSuccess));
      //emit(state.copyWith(userBlocks: resp ));
    }catch(e){
      emit(state.copyWith(status: ProfileStatus.fail));
      log(('errorr :'));
      log(e.toString());
    }
  }
}


