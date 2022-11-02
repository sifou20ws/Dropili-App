import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dropili/data/models/get_blocks_model.dart';
import 'package:dropili/data/models/post_user_blocks.dart';
import 'package:dropili/data/models/post_user_profile_response.dart';
import 'package:dropili/domain/repositories/edit_profile_repository.dart';
import 'package:equatable/equatable.dart';

import 'package:image_picker/image_picker.dart';

part 'editProfileScreen_event.dart';
part 'editProfileScreen_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileRepository _editProfileRepository;
  EditProfileBloc({required EditProfileRepository editProfileRepository})
      : _editProfileRepository = editProfileRepository,
        super(EditProfileState(blocks: [])) {
    on<ItemSelectedEvent>(_itemSelectedEvent);
    on<SwitchEvent>(_switchEvent);
    on<GetBlocksEvent>(_getBlocks);
    on<ImportCoverImageEvent>(_importCoverImageEvent);
    on<ImportProfileImageEvent>(_importProfileImageEvent);
    on<PostBlocksEvent>(_postBlocksEvent);
    on<PostProfileUpdateEvent>(_postProfileUpdateEvent);
    on<PostUserNameEvent>(_postUserNameEvent);
    on<PostDescriptionEvent>(_postDescriptionEvent);
    on<GetProfileEvent>(_getProfileEvent);
    on<BlockUrlEvent>(_blockUrlEvent);
  }

  void _getBlocks(GetBlocksEvent event, Emitter<EditProfileState> emit) async {
    emit(state.copyWith(status: Status.loading));
    var resp;
    try {
      resp = await _editProfileRepository.getBlocks();
      emit(state.copyWith(status: Status.getSuccess));
      emit(state.copyWith(blocks: resp));
      log(resp[0].title.fr.toString());
    } catch (e) {
      emit(state.copyWith(status: Status.fail));
      log(('error :'));
      log(e.toString());
    }
  }

  void _itemSelectedEvent(
      ItemSelectedEvent event, Emitter<EditProfileState> emit) async {
    emit(state.copyWith(index: event.index));
    //emit(state.copyWith(status: Status.loading));
    var resp;
    try {
      log(event.index.toString());
      PostUserBlocks data =
          PostUserBlocks(id: event.index + 1, url: event.data);
      resp = await _editProfileRepository.PostUserBlocks(data.toJson());
      emit(state.copyWith(status: Status.getSuccess));
      //emit(state.copyWith(blocks: resp));
      log(resp.toString());
    } catch (e) {
      emit(state.copyWith(status: Status.fail));
      log(('error :'));
      log(e.toString());
    }
    //log(state.blocks[event.index].title.ar);
  }

  void _postBlocksEvent(
      PostBlocksEvent event, Emitter<EditProfileState> emit) async {
    var resp;
    try {
      // PostUserBlocks data = PostUserBlocks(id: event.index+1 , url: event.data);
      resp = await _editProfileRepository.PostUserBlocks(event.data);
      //emit(state.copyWith(status: Status.getSuccess));
      //emit(state.copyWith(blocks: resp));
      log(resp.body);
    } catch (e) {
      emit(state.copyWith(status: Status.fail));
      log(('error :'));
      log(e.toString());
    }
    //log(state.blocks[event.index].title.ar);
  }

  void _switchEvent(SwitchEvent event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(switchButton: event.state));
  }

  void _blockUrlEvent(BlockUrlEvent event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(blockUrl: event.url));
  }

  void _importCoverImageEvent(
      ImportCoverImageEvent event, Emitter<EditProfileState> emit) async {
    XFile? file;
    try {
      file = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (file != null) {
        emit(state.copyWith(coverImagePath: file.path));
        emit(state.copyWith(backgroundImg: file.path));
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void _importProfileImageEvent(
      ImportProfileImageEvent event, Emitter<EditProfileState> emit) async {
    //emit(state.copyWith(status: Status.loading));
    XFile? file;
    try {
      file = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (file != null) {
        emit(state.copyWith(profileImagePath: file.path));
        emit(state.copyWith(profileImg: file.path));
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void _postUserNameEvent(
      PostUserNameEvent event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(userName: event.name));
  }

  void _postDescriptionEvent(
      PostDescriptionEvent event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(userDescription: event.description));
  }

  void _postProfileUpdateEvent(
      PostProfileUpdateEvent event, Emitter<EditProfileState> emit) async {
    if (event.name.isEmpty) {
      emit(state.copyWith(status: Status.initial));
      emit(state.copyWith(
        status: Status.fail,
        errorExist: true,
        messageError: 'name field is required',
      ));
      emit(state.copyWith(valideName: false));
      return;
    }

    var resp;
    Map<String, String> map1 = {
      'name': event.name,
      'description': event.description
    };
    try {
      resp = await _editProfileRepository.PostUserProfile(
          profile: event.profile, background: event.background, data: map1);
      PostProfileResp profileResp = PostProfileResp.fromJson(resp);
      log(profileResp.success.toString());
      (profileResp.success)
          ? emit(state.copyWith(
              status: Status.success, messageError: profileResp.message))
          : emit(state.copyWith(
              status: Status.fail, messageError: profileResp.message));

      ;
    } catch (e) {
      log('bloc:');
      log(e.toString());
    }
  }

  void _getProfileEvent(
      GetProfileEvent event, Emitter<EditProfileState> emit) async {
    emit(state.copyWith(status: Status.loading));
    var resp;
    try {
      resp = await _editProfileRepository.getProfileShow();
      emit(state.copyWith(status: Status.getSuccess));
      emit(state.copyWith(showProfile: resp));
      //log(resp.toString());
    } catch (e) {
      emit(state.copyWith(status: Status.fail));
      log(('error :'));
      log(e.toString());
    }
  }
}
