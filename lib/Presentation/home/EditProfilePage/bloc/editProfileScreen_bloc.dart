import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dropili/data/models/costume_block_response.dart';
import 'package:dropili/data/models/get_blocks_model.dart';
import 'package:dropili/data/models/get_costume_block_response.dart';
import 'package:dropili/data/models/post_user_blocks.dart';
import 'package:dropili/data/models/post_user_profile_response.dart';
import 'package:dropili/domain/repositories/profile_repository.dart';
import 'package:equatable/equatable.dart';

import 'package:image_picker/image_picker.dart';

part 'editProfileScreen_event.dart';
part 'editProfileScreen_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  ProfileRepository _ProfileRepository;
  EditProfileBloc({required ProfileRepository ProfileRepository})
      : _ProfileRepository = ProfileRepository,
        super(EditProfileState(
            blocks: [], userBlocks: [], blocksList: [], costumeBlocks: [])) {
    on<GetBlocksEvent>(_getBlocks);
    on<GetUserBlocksEvent>(_getUserBlocks);
    on<ItemSelectedEvent>(_itemSelectedEvent);
    on<SwitchEvent>(_switchEvent);
    on<ActiveEvent>(_activeEvent);
    on<ImportCoverImageEvent>(_importCoverImageEvent);
    on<ImportProfileImageEvent>(_importProfileImageEvent);
    on<PostBlocksEvent>(_postBlocksEvent);
    on<DirectOnMeEvent>(_directOnMeEvent);
    on<PostProfileUpdateEvent>(_postProfileUpdateEvent);
    on<PostUserNameEvent>(_postUserNameEvent);
    on<PostDescriptionEvent>(_postDescriptionEvent);
    on<GetProfileEvent>(_getProfileEvent);
    on<BlockUrlEvent>(_blockUrlEvent);
    on<DeleteUserBlocksEvent>(_deleteUserBlocksEvent);
    on<GetCostumeBlockImage>(_getCostumeBlockImage);
    on<PostCostumeBlock>(_postCostumeBlock);
    on<ProfileActiveEvent>(_profileActiveEvent);
    on<GetCostumeBlocksEvent>(_getCostumeBlocksEvent);
    on<DeleteCostumeBlocksEvent>(_deleteCostumeBlocksEvent);
    on<UpdateCostumeBlock>(_updateCostumeBlock);

  }

  void _getBlocks(GetBlocksEvent event, Emitter<EditProfileState> emit) async {
    emit(state.copyWith(status: Status.loadingBlocks));
    emit(state.copyWith(blocksStatus: BlocksStatus.getBlocks));
    var resp;
    List<List<BlocksItem>> blocksList;
    final List<BlocksItem> blocks;
    try {
      resp = await _ProfileRepository.getBlocks();
      emit(state.copyWith(blocks: resp.blocks));
      emit(state.copyWith(userBlocks: resp.userBlocks));
      blocks = resp.blocks;
      blocksList = [
        blocks.where((element) => element.type == 1).toList(),
        blocks.where((element) => element.type == 2).toList(),
        blocks.where((element) => element.type == 3).toList(),
        blocks.where((element) => element.type == 4).toList(),
      ];
      emit(state.copyWith(
        blocksList: blocksList,
        status: Status.getBlocksSuccess,
      ));
      emit(state.copyWith(blocksStatus: BlocksStatus.getBlocksSuccess));
      //log(resp.blocks.toString());
      //log(state.userBlocks.toString(), name: 'UBL in bloc');
    } catch (e) {
      emit(state.copyWith(status: Status.fail));
      log(('error :'));
      log(e.toString());
    }
  }

  void _getUserBlocks(
      GetUserBlocksEvent event, Emitter<EditProfileState> emit) async {
    emit(state.copyWith(status: Status.loadingUserBlocks));
    var resp;
    try {
      resp = await _ProfileRepository.getBlocks();
      emit(state.copyWith(userBlocks: resp.userBlocks));
      emit(state.copyWith(status: Status.getUserBlocksSuccess));
      //log(resp.blocks.toString());
      //log(state.userBlocks.toString(), name: 'UBL in bloc');
    } catch (e) {
      emit(state.copyWith(status: Status.fail));
      log(('error :'));
      log(e.toString());
    }
  }

  void _deleteUserBlocksEvent(
      DeleteUserBlocksEvent event, Emitter<EditProfileState> emit) async {
    emit(state.copyWith(status: Status.deleteLoading));
    var resp;
    try {
      resp = await _ProfileRepository.deleteBlocks(event.id);
      emit(state.copyWith(status: Status.deleteSuccess));
      //emit(state.copyWith(userBlocks: resp ));
      log(resp.success.toString(), name: 'delete blocks :');
    } catch (e) {
      emit(state.copyWith(
          status: Status.failInBlocksDialogue, messageError: e.toString()));
      log(('errorr :'));
      log(e.toString());
    }
  }

  void _itemSelectedEvent(
      ItemSelectedEvent event, Emitter<EditProfileState> emit) async {
    if (event.data.isEmpty) {
      log('error');
      emit(state.copyWith(
        status: Status.postBlockInvalidUrl,
      ));
      //emit(state.copyWith(valideName: false));
      return;
    }

    emit(state.copyWith(index: event.index));
    emit(state.copyWith(status: Status.postBlockLoading, load: true));

    var resp;
    try {
      log(event.index.toString());

      PostUserBlocks data = PostUserBlocks(id: event.index, url: event.data);

      event.put
          ? resp =
              await _ProfileRepository.PutUserBlocks(data.toJson(), event.index)
          : resp = await _ProfileRepository.PostUserBlocks(data.toJson());
      emit(state.copyWith(status: Status.postBlockSuccess, load: false));
      //emit(state.copyWith(blocks: resp));
      log(resp.toString());
    } catch (e) {
      emit(state.copyWith(status: Status.failInBlocksDialogue));
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
      resp = await _ProfileRepository.PostUserBlocks(event.data);
      //emit(state.copyWith(status: Status.getSuccess));
      //emit(state.copyWith(blocks: resp));
      log(resp.body, name: 'post block :');
    } catch (e) {
      emit(state.copyWith(status: Status.failInBlocksDialogue));
      log(('error :'));
      log(e.toString());
    }
    //log(state.blocks[event.index].title.ar);
  }

  void _switchEvent(SwitchEvent event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(
      switchButton: event.state,
      openDirectMeDialogue: event.state,
    ));
  }
  void _activeEvent(ActiveEvent event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(
      activeButton: event.state,
    ));
  }

  void _profileActiveEvent(
      ProfileActiveEvent event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(
      profileActiveButton: event.state,
    ));
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
    log(event.name, name: 'postusername');
  }

  void _postDescriptionEvent(
      PostDescriptionEvent event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(userDescription: event.description));
    log(event.description, name: 'postdescription');
  }

  void _postProfileUpdateEvent(
      PostProfileUpdateEvent event, Emitter<EditProfileState> emit) async {
    if (event.name.isEmpty) {
      log('error');
      emit(state.copyWith(
        status: Status.profileUpdateFail,
        errorExist: true,
        messageError: 'name field is required',
      ));
      emit(state.copyWith(valideName: false));
      return;
    }

    emit(state.copyWith(status: Status.loadingProfileUpdate));

    var resp;
    Map<String, String> map1 = {
      'name': event.name,
      'description': event.description,
      'active': event.active? 'yes' : 'no'
    };
    try {
      resp = await _ProfileRepository.PostUserProfile(
          profile: event.profile, background: event.background, data: map1);
      PostProfileResp profileResp = PostProfileResp.fromJson(resp);
      (profileResp.success)
          ? emit(state.copyWith(
              status: Status.profileUpdateSucess,
              messageError: profileResp.message))
          : emit(state.copyWith(
              status: Status.profileUpdateFail,
              messageError: profileResp.message));

      ;
    } catch (e) {
      emit(state.copyWith(
        status: Status.profileUpdateFail,
        messageError: e.toString(),
      ));
      log(e.toString());
    }
  }

  void _getProfileEvent(
      GetProfileEvent event, Emitter<EditProfileState> emit) async {
    emit(state.copyWith(status: Status.loadingProfile));
    PostProfileResp resp;
    try {
      resp = await _ProfileRepository.getProfileShow();
      emit(state.copyWith(status: Status.getProfileSuccess));
      emit(state.copyWith(
          showProfile: resp, switchButton: resp.user.directOnMe));
      //log(resp.toString());
    } catch (e) {
      emit(state.copyWith(status: Status.fail));
      log(('error :'));
      log(e.toString());
    }
  }

  void _directOnMeEvent(
      DirectOnMeEvent event, Emitter<EditProfileState> emit) async {
    var resp;
    Map<String, dynamic> map1 = {
      'direct': event.direct,
      'url': event.url,
      'block_id': event.block_id
    };
    PostProfileResp showProfile;
    try {
      resp = await _ProfileRepository.directOnMe(data: map1);

      showProfile = await _ProfileRepository.getProfileShow();
      emit(state.copyWith(
        profileUserUrl: showProfile.user.url,
        status: Status.directOnMeSuccess,
      ));
      log(resp.toString(), name: 'edit bloc :');
      log(showProfile.user.directOnMe.toString(), name: 'direct_on_me');
      log(state.profileUserUrl, name: 'after updating');
    } catch (e) {
      log('bloc:');
      log(e.toString());
    }
  }

  void _getCostumeBlockImage(
      GetCostumeBlockImage event, Emitter<EditProfileState> emit) async {
    XFile? file;
    try {
      file = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (file != null) {
        emit(state.copyWith(
            addCostumeBlockImgPath: file.path, status: Status.costumeBlockImageSuccess));
        log(state.addCostumeBlockImgPath, name: 'costume block image path');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void _postCostumeBlock(
      PostCostumeBlock event, Emitter<EditProfileState> emit) async {
    if (event.url.isEmpty || event.titleAr.isEmpty || event.titleFr.isEmpty) {
      emit(state.copyWith(
        status: Status.postCostumeBlocksInvalidTitleAr,
        messageError: 'url field is required',
      ));
      return;
    }

    emit(state.copyWith(status: Status.postCostumeBlocksLoading));
    var resp;
    Map<String, String> map1 = {
      'url': event.url,
      'title[ar]': event.titleAr,
      'title[fr]': event.titleFr
    };

    try {
      resp = await _ProfileRepository.PostCostumeBlock(
        icon: event.icon,
        data: map1,
      );
      CostumeBlockResponse costumeBlockResp =
          CostumeBlockResponse.fromJson(resp);
      (costumeBlockResp.success)
          ? emit(state.copyWith(
              status: Status.postCostumeBlocksSuccess, messageError: costumeBlockResp.message))
          : emit(state.copyWith(
              status: Status.postCostumeBlocksFail, messageError: costumeBlockResp.message));

      ;
      log(resp.toString());
    } catch (e) {
      emit(state.copyWith(
          status: Status.postCostumeBlocksFail, messageError: e.toString()));
      log('bloc:');
      log(e.toString());
    }
  }

  void _updateCostumeBlock(
      UpdateCostumeBlock event, Emitter<EditProfileState> emit) async {
    emit(state.copyWith(status: Status.deleteCostumeBlocksLoading));
    var resp;
    Map<String, String> map1 = {
      'url': event.url,
      'title[ar]': event.titleAr,
      'title[fr]': event.titleFr
    };

    try {
      resp = await _ProfileRepository.UpdateCostumeBlock(
        icon: event.icon,
        data: map1,
        id: event.id,
      );
      CostumeBlockResponse costumeBlockResp =
      CostumeBlockResponse.fromJson(resp);
      (costumeBlockResp.success)
          ? emit(state.copyWith(
          status: Status.deleteCostumeBlocksSuccess, messageError: costumeBlockResp.message))
          : emit(state.copyWith(
          status: Status.deleteCostumeBlocksFail, messageError: costumeBlockResp.message));

      ;
      log(resp.toString());
    } catch (e) {
      emit(state.copyWith(
          status: Status.postCostumeBlocksFail, messageError: e.toString()));
      log('bloc:');
      log(e.toString());
    }
  }

  void _getCostumeBlocksEvent(
      GetCostumeBlocksEvent event, Emitter<EditProfileState> emit) async {
    emit(state.copyWith(status: Status.getCostumeBlocks));
    emit(state.copyWith(costumeBlocksStatus: CostumeBlocksStatus.getCostumeBlocks));

    GetCostumeBlocksResponse resp;
    final List<CustomBlocksItem> costumeBlocks;

    try {
      resp = await _ProfileRepository.getCostumeBlocks();
      costumeBlocks = resp.customBlocks;

      emit(state.copyWith(
        costumeBlocks: costumeBlocks,
        status: Status.getCostumeBlocksSuccess,
      ));
      emit(state.copyWith(costumeBlocksStatus: CostumeBlocksStatus.getCostumeBlocksSuccess));

      //log(costumeBlocks[2].icon.toString());
      //log(state.userBlocks.toString(), name: 'UBL in bloc');
    } catch (e) {
      emit(state.copyWith(status: Status.getCostumeBlocksFail));
      log(('error :'));
      log(e.toString());
    }
  }

  void _deleteCostumeBlocksEvent(
      DeleteCostumeBlocksEvent event, Emitter<EditProfileState> emit) async {
    emit(state.copyWith(status: Status.deleteCostumeBlocksLoading));
    var resp;
    try {
      resp = await _ProfileRepository.deleteCostumeBlocks(event.id);
      emit(state.copyWith(status: Status.deleteCostumeBlocksSuccess));
      //emit(state.copyWith(userBlocks: resp ));
      log(resp.success.toString(), name: 'delete blocks :');
    } catch (e) {
      emit(state.copyWith(
          status: Status.deleteCostumeBlocksFail, messageError: e.toString()));
      log(('errorr :'));
      log(e.toString());
    }
  }

}

