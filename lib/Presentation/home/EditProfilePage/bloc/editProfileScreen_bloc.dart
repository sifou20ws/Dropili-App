import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dropili/common/constant/colors.dart';
import 'package:dropili/data/models/costume_block_response.dart';
import 'package:dropili/data/models/get_blocks_model.dart';
import 'package:dropili/data/models/get_costume_block_response.dart';
import 'package:dropili/data/models/post_user_blocks.dart';
import 'package:dropili/data/models/post_user_profile_response.dart';
import 'package:dropili/domain/repositories/profile_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

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
    on<ResetCostumeBlocksEvent>(_resetCostumeBlocksEvent);
    on<CostumeFileEvent>(_costumeFileEvent);
    on<CostumeUrlEvent>(_costumeUrlEvent);
    on<GetCostumeBlockFile>(_getCostumeBlockFile);
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
          blocksStatus: BlocksStatus.getBlocksSuccess));
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
      // log(resp.success.toString(), name: 'delete blocks :');
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
      // log(event.index.toString());

      PostUserBlocks data = PostUserBlocks(id: event.index, url: event.data);

      event.put
          ? resp =
              await _ProfileRepository.PutUserBlocks(data.toJson(), event.index)
          : resp = await _ProfileRepository.PostUserBlocks(data.toJson());
      emit(state.copyWith(status: Status.postBlockSuccess, load: false));
      //emit(state.copyWith(blocks: resp));
      // log(resp.toString());
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
        String croppedFile =
            await cropImage(file: file, ratioY: 1, ratioX: 1.5);

        log('success', name: 'cropped');
        emit(state.copyWith(coverImagePath: croppedFile));
        emit(state.copyWith(backgroundImg: croppedFile));
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void _importProfileImageEvent(
      ImportProfileImageEvent event, Emitter<EditProfileState> emit) async {
    XFile? file;
    try {
      file = await ImagePicker().pickImage(source: ImageSource.gallery);
      // if (file != null) {
      //   emit(state.copyWith(profileImagePath: file.path));
      //   emit(state.copyWith(profileImg: file.path));
      // }
      if (file != null) {
        String croppedFile = await cropImage(file: file, ratioY: 1, ratioX: 1);

        log('success', name: 'cropped');
        emit(state.copyWith(profileImagePath: croppedFile));
        emit(state.copyWith(profileImg: croppedFile));
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void _postUserNameEvent(
      PostUserNameEvent event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(userName: event.name));
    // log(event.name, name: 'postusername');
  }

  void _postDescriptionEvent(
      PostDescriptionEvent event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(userDescription: event.description));
    // log(event.description, name: 'postdescription');
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
      'active': event.active ? 'yes' : 'no'
    };
    try {
      resp = await _ProfileRepository.PostUserProfile(
          profile: event.profile, background: event.background, data: map1);
      PostProfileResp profileResp = PostProfileResp.fromJson(resp);
      (profileResp.success)
          ? emit(state.copyWith(
              messageError: profileResp.message,
              status: Status.profileUpdateSucess,
            ))
          : emit(state.copyWith(
              messageError: profileResp.message,
              status: Status.profileUpdateFail,
            ));

      ;
    } catch (e) {
      emit(state.copyWith(
        messageError: e.toString(),
        status: Status.profileUpdateFail,
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
      emit(
        state.copyWith(
          showProfile: resp,
          switchButton: resp.user.directOnMe,
          status: Status.getProfileSuccess,
        ),
      );
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
    } catch (e) {
      emit(state.copyWith(
          status: Status.directOnMeFail, messageError: e.toString()));
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
        String croppedFile = await cropImage(file: file, ratioY: 1, ratioX: 1);

        log('success', name: 'cropped');
        emit(state.copyWith(addCostumeBlockImgPath: croppedFile));
        emit(state.copyWith(status: Status.costumeBlockImageSuccess));
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void _getCostumeBlockFile(
      GetCostumeBlockFile event, Emitter<EditProfileState> emit) async {
    //XFile? file;
    String? filePath, fileName;
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg'],
      );

      if (result != null) {
        filePath = result.files.single.path;
        fileName = result.files.single.name;

        log(fileName, name: 'file name');
        log(filePath!, name: 'file path');

        emit(state.copyWith(
          fileName: fileName,
          filePath: filePath,
        ));
      } else {
        log('no file selected');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void _postCostumeBlock(
      PostCostumeBlock event, Emitter<EditProfileState> emit) async {
    if (event.titleAr.isEmpty) {
      emit(state.copyWith(
        messageError: 'this field is required',
        cBValideName: !event.titleAr.isEmpty,
      ));
      log(state.cBValideName.toString(), name: 'ar bloc');
      return;
    }

    Map<String, String> map1;

    if (event.fileOrUrl==true) {
      if (event.url.isEmpty) {
        emit(state.copyWith(
          messageError: 'this field is required',
          cBValideUrl: false,
        ));
        log(state.cBValideUrl.toString(), name: 'url');
        return;
      }else{
        map1 = {
          'url': event.url ,
          'title[ar]': event.titleAr,
          'title[fr]': event.titleAr
        };
      }
    }else{
      if (event.file.isEmpty) {
        emit(state.copyWith(
          messageError: 'this field is required',
          cBValideFile: false,
        ));
        log(state.cBValideFile.toString(), name: 'file');
        return;
      }else{
        map1 = {
          'title[ar]': event.titleAr,
          'title[fr]': event.titleAr
        };
      }
    }

    emit(state.copyWith(status: Status.postCostumeBlocksLoading));
    var resp;

    try {
      resp = await _ProfileRepository.PostCostumeBlock(
        icon: event.icon,
        data: map1,
        file: event.file,
        fileName: state.fileName,
      );
      CostumeBlockResponse costumeBlockResp =
          CostumeBlockResponse.fromJson(resp);
      (costumeBlockResp.success)
          ? emit(state.copyWith(
              messageError: costumeBlockResp.message,
              status: Status.postCostumeBlocksSuccess,
            ))
          : emit(state.copyWith(
              messageError: costumeBlockResp.message,
              status: Status.postCostumeBlocksFail,
            ));

      ;
      log(resp.toString());
    } catch (e) {
      emit(state.copyWith(
        messageError: e.toString(),
        status: Status.postCostumeBlocksFail,
      ));
      log('bloc:');
      log(e.toString());
    }
  }

  void _updateCostumeBlock(
      UpdateCostumeBlock event, Emitter<EditProfileState> emit) async {
    emit(state.copyWith(status: Status.updateCostumeBlocksLoading));
    var resp;
    Map<String, String> map1;
    if(event.urlOrFile){
      map1 = {
        'url': event.url,
        'title[ar]': event.title,
        'title[fr]': event.title
      };
    }else{
      map1 = {
        'url' : '.',
        'title[ar]': event.title,
        'title[fr]': event.title
      };
    }

    try {
      log(event.file,name: 'file path bloc');
      log(event.urlOrFile.toString(),name: 'file path bloc');
      resp = await _ProfileRepository.UpdateCostumeBlock(
        icon: event.icon,
        data: map1,
        id: event.id,
        file: event.file,
        fileName: event.fileName,
        urlOrFile: event.urlOrFile,
      );
      CostumeBlockResponse costumeBlockResp =
          CostumeBlockResponse.fromJson(resp);
      (costumeBlockResp.success)
          ? emit(state.copyWith(
              messageError: costumeBlockResp.message,
              status: Status.deleteCostumeBlocksSuccess,
            ))
          : emit(state.copyWith(
              messageError: costumeBlockResp.message,
              status: Status.deleteCostumeBlocksFail,
            ));

      ;
      // log(resp.toString());
    } catch (e) {
      emit(state.copyWith(
        messageError: e.toString(),
        status: Status.postCostumeBlocksFail,
      ));
      log('bloc:');
      log(e.toString());
    }
  }


  void _getCostumeBlocksEvent(
      GetCostumeBlocksEvent event, Emitter<EditProfileState> emit) async {
    emit(state.copyWith(status: Status.getCostumeBlocks));
    emit(state.copyWith(
        costumeBlocksStatus: CostumeBlocksStatus.getCostumeBlocks));

    GetCostumeBlocksResponse resp;
    final List<CustomBlocksItem> costumeBlocks;

    try {
      resp = await _ProfileRepository.getCostumeBlocks();
      costumeBlocks = resp.customBlocks;

      emit(state.copyWith(
          costumeBlocks: costumeBlocks,
          status: Status.getCostumeBlocksSuccess,
          costumeBlocksStatus: CostumeBlocksStatus.getCostumeBlocksSuccess));

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
      //log(resp.success.toString(), name: 'delete blocks :');
    } catch (e) {
      emit(state.copyWith(
        messageError: e.toString(),
        status: Status.deleteCostumeBlocksFail,
      ));
      log(('errorr :'));
      log(e.toString());
    }
  }

  void _resetCostumeBlocksEvent(
      ResetCostumeBlocksEvent event, Emitter<EditProfileState> emit) async {
    emit(state.copyWith(
        cBValideName: true,
        cBValideFile: true,
        cBValideUrl: true,
        addCostumeBlockImgPath : '',
        fileName: ''));
  }

  void _costumeFileEvent(
      CostumeFileEvent event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(
      fileOrUrl: false,
    ));
  }

  void _costumeUrlEvent(CostumeUrlEvent event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(
      fileOrUrl: true,
    ));
  }

  Future<String> cropImage(
      {required XFile file,
      required double ratioY,
      required double ratioX}) async {
    CroppedFile? croppedFile = (await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatio: CropAspectRatio(
        ratioY: ratioY,
        ratioX: ratioX,
      ),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Edit your image',
          toolbarColor: MalinColors.AppBlue,
          toolbarWidgetColor: Colors.white,
          activeControlsWidgetColor: MalinColors.AppGreen,
          initAspectRatio: CropAspectRatioPreset.original,
          cropFrameStrokeWidth: 10,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    ));

    if (croppedFile == null) {
      return '';
    }
    return croppedFile.path;
  }
}
