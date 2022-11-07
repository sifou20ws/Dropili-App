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
        super(ProfileState(userBlocks: [])) {
    on<EditButtonClickedEvent>(_editButtonClickedEvent);
    on<GetUserBlocksEvent>(_getUserBlocksEvent);
    on<GetProfileEvent>(_getProfileEvent);
    // on<DeleteUserBlocksEvent>(_deleteUserBlocksEvent);
  }

  void _editButtonClickedEvent(event, Emitter<ProfileState> emit) {
    emit(state.copyWith(status: ProfileStatus.success));
  }

  void _getUserBlocksEvent(event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    List<List<UserBlocksItem>>? userBlocksLists;
    try {
      var resp = await _editProfileRepository.getUserBlocks();

      userBlocksLists = [
        resp.where((element) => element.type == 1).toList(),
        resp.where((element) => element.type == 2).toList(),
        resp.where((element) => element.type == 3).toList(),
        resp.where((element) => element.type == 4).toList(),
      ]..removeWhere((element) => element.isEmpty);

      emit(state.copyWith(userBlocks: userBlocksLists));
      emit(state.copyWith(status: ProfileStatus.getSuccess));
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.fail,
          messageError: e.toString(),
        ),
      );
    }
  }

  void _getProfileEvent(
      GetProfileEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    var resp;
    try {
      resp = await _editProfileRepository.getProfileShow();
      emit(state.copyWith(showProfile: resp));
      emit(state.copyWith(status: ProfileStatus.getSuccess));
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.fail,
          messageError: e.toString(),
        ),
      );
    }
  }

  // void _deleteUserBlocksEvent(DeleteUserBlocksEvent event, Emitter<ProfileState> emit) async{
  //   //emit(state.copyWith(status: ProfileStatus.loading));
  //   var resp;
  //   try{
  //     resp = await  _editProfileRepository.deleteBlocks(event.id);
  //     //emit(state.copyWith(status: ProfileStatus.getSuccess));
  //     //emit(state.copyWith(userBlocks: resp ));
  //   }catch(e){
  //     emit(state.copyWith(status: ProfileStatus.fail));
  //     log(('errorr :'));
  //     log(e.toString());
  //   }
  // }
}
