part of 'editProfileScreen_bloc.dart';

enum Status {
  initial,
  loading,
  success,
  fail,
  finish,

  loadingBlocks,
  getBlocksSuccess,
  getUserBlocksSuccess,
  loadingUserBlocks,
  postBlockLoading,
  postBlockSuccess,
  postBlockInvalidUrl,
  postBlockFail,
  deleteLoading,
  deleteSuccess,
  failInBlocksDialogue,

  getCostumeBlocks,
  getCostumeBlocksSuccess,
  getCostumeBlocksFail,
  postCostumeBlocksLoading,
  postCostumeBlocksSuccess,
  postCostumeBlocksInvalidUrl,
  postCostumeBlocksInvalidTitleAr,
  postCostumeBlocksInvalidTitleFr,
  postCostumeBlocksFail,
  updateCostumeBlocksLoading,
  updateCostumeBlocksSuccess,
  updateCostumeBlocksFail,
  deleteCostumeBlocksLoading,
  deleteCostumeBlocksSuccess,
  deleteCostumeBlocksFail,
  costumeBlockImageSuccess,

  loadingProfile,
  getProfileSuccess,
  loadingProfileUpdate,
  profileUpdateSucess,
  profileUpdateFail,

  costumeBlock,
  directOnMeSuccess,
}

enum BlocksStatus {
  initial,
  getBlocks,
  getBlocksSuccess,
  getBlocksFail,
  getUserBlocks,
  getUserBlocksSuccess,
  getUserBlocksFail,
  postBlock,
  postBlockSuccess,
  postBlockFail,
  invalidUrl,
  deleteBlocks,
  deleteBlocksSuccess,
  deleteBlocksFail,
}

enum CostumeBlocksStatus {
  initial,
  getCostumeBlocks,
  getCostumeBlocksSuccess,
  getCostumeBlocksFail,
  postCostumeBlocksLoading,
  postCostumeBlocksSuccess,
  postCostumeBlocksInvalidUrl,
  postCostumeBlocksInvalidTitleAr,
  postCostumeBlocksInvalidTitleFr,
  postCostumeBlocksFail,
  updateCostumeBlocksLoading,
  updateCostumeBlocksSuccess,
  updateCostumeBlocksFail,
  deleteCostumeBlocksLoading,
  deleteCostumeBlocksSuccess,
  deleteCostumeBlocksFail,
  costumeBlockImageSuccess,
}

enum ProfileStatus {
  loadingProfile,
  getProfileSuccess,
  loadingProfileUpdate,
  profileUpdateSucess,
  profileUpdateFail,
}

class EditProfileState extends Equatable {
  EditProfileState(
      {this.switchButton = false,
      this.profileActiveButton = false,
      this.messageError = '',
      this.errorExist = false,
      this.status = Status.loading,
      /** */ this.blocksStatus = BlocksStatus.initial,
      /** */ this.costumeBlocksStatus = CostumeBlocksStatus.initial,
      this.id = '',
      /** Blocks and user blocks */
      required this.blocks,
      required this.costumeBlocks,
      required this.blocksList,
      this.index = -1,
      required this.userBlocks,
      /** profile */
      this.userName = '',
      this.userDescription = '',
      this.backgroundImg = '',
      this.profileImg = '',
      this.showProfile,
      this.profileUserUrl = '',
      this.valideName = true,
      this.coverImagePath = '',
      this.profileImagePath = '',
      this.addCostumeBlockImgPath = 'assets/dropili_app_logo.png',
      this.load = false,
      this.openDirectMeDialogue = false,
      this.blockUrl = ''});

  final bool errorExist;
  bool load;
  final String messageError;
  Status status;
  /** */ final BlocksStatus blocksStatus;
  /** */ final CostumeBlocksStatus costumeBlocksStatus;
  final bool switchButton;
  final bool profileActiveButton;
  final String id;
  final int index;
  String coverImagePath = '';
  String profileImagePath = '';
  final List<BlocksItem> blocks;
  final List<List<BlocksItem>> blocksList;
  final List<CustomBlocksItem> costumeBlocks;
  final String userName;
  final String userDescription;
  String addCostumeBlockImgPath = '';
  final String backgroundImg;
  bool openDirectMeDialogue;
  final String profileImg;
  final PostProfileResp? showProfile;
  final String blockUrl;
  final bool valideName;
  final List<UserBlocksItem> userBlocks;
  String profileUserUrl;

  EditProfileState copyWith(
      {bool? switchButton,
      bool? profileActiveButton,
      String? messageError,
      Status? status,
      /** */ BlocksStatus? blocksStatus,
      /** */ CostumeBlocksStatus? costumeBlocksStatus,
      String? id,
      int? index,
      List<BlocksItem>? blocks,
      List<UserBlocksItem>? userBlocks,
      String? coverImagePath,
      String? profileImagePath,
      String? backgroundImg,
      String? profileImg,
      String? userName,
      String? addCostumeBlockImgPath,
      String? userDescription,
      PostProfileResp? showProfile,
      String? blockUrl,
      bool? errorExist,
      bool? valideName,
      bool? openDirectMeDialogue,
      bool? load,
      String? profileUserUrl,
      List<CustomBlocksItem>? costumeBlocks,
      List<List<BlocksItem>>? blocksList}) {
    return EditProfileState(
      messageError: messageError ?? this.messageError,
      status: status ?? this.status,
      switchButton: switchButton ?? this.switchButton,
      profileActiveButton: profileActiveButton ?? this.profileActiveButton,
      id: id ?? this.id,
      index: index ?? this.index,
      blocks: blocks ?? this.blocks,
      coverImagePath: coverImagePath ?? this.coverImagePath,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      userName: userName ?? this.userName,
      userDescription: userDescription ?? this.userDescription,
      profileImg: profileImg ?? this.profileImg,
      backgroundImg: backgroundImg ?? this.backgroundImg,
      showProfile: showProfile ?? this.showProfile,
      blockUrl: blockUrl ?? this.blockUrl,
      errorExist: errorExist ?? this.errorExist,
      addCostumeBlockImgPath:
          addCostumeBlockImgPath ?? this.addCostumeBlockImgPath,
      valideName: valideName ?? this.valideName,
      userBlocks: userBlocks ?? this.userBlocks,
      load: load ?? this.load,
      profileUserUrl: profileUserUrl ?? this.profileUserUrl,
      blocksList: blocksList ?? this.blocksList,
      openDirectMeDialogue: openDirectMeDialogue ?? this.openDirectMeDialogue,
      costumeBlocks: costumeBlocks ?? this.costumeBlocks,
      /** */ blocksStatus: blocksStatus ?? this.blocksStatus,
      /** */ costumeBlocksStatus:
          costumeBlocksStatus ?? this.costumeBlocksStatus,
    );
  }

  @override
  List<Object?> get props => [
        messageError,
        status,
        switchButton,
        profileActiveButton,
        id,
        index,
        blocks,
        load,
        coverImagePath,
        profileImagePath,
        addCostumeBlockImgPath,
        profileUserUrl,
        userName,
        userDescription,
        profileImg,
        backgroundImg,
        showProfile,
        /** */ blocksStatus,
        /** */ costumeBlocksStatus,
        blockUrl,
        errorExist,
        valideName,
        userBlocks,
        blocksList,
        openDirectMeDialogue,
        costumeBlocks,
      ];
}
