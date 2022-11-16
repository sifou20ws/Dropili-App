part of 'editProfileScreen_bloc.dart';

enum Status {
  directOnMeSuccess,
  initial,
  loading,
  success,
  fail,
  finish,
  getProfileSuccess,
  getBlocksSuccess,
  loadingBlocks,
  getUserBlocksSuccess,
  loadingUserBlocks,
  loadingProfile,
  postBlockLoading,
  postBlockSuccess,
  deleteLoading,
  deleteSuccess,
  loadingProfileUpdate,
  profileUpdateSucess,
  failInDialogue,
  costumeBlock
}

class EditProfileState extends Equatable {
  EditProfileState(
      {this.switchButton = false,
      this.messageError = '',
      this.errorExist = false,
      this.status = Status.loading,
      this.id = '',
      required this.blocksList,
      this.index = -1,
      required this.blocks,
      required this.userBlocks,
      this.coverImagePath = '',
      this.profileImagePath = '',
      this.userName = '',
      this.userDescription = '',
      this.backgroundImg = '',
      this.profileImg = '',
      this.showProfile,
      this.addCostumeBlockImgPath = 'assets/dropili_app_logo.png',
      this.profileUserUrl = '',
      this.valideName = true,
      this.load = false,
      this.openDirectMeDialogue = false,
      this.blockUrl = ''});

  final bool errorExist;
  bool load;
  final String messageError;
  final Status status;
  final bool switchButton;
  final String id;
  final int index;
  String coverImagePath = '';
  String profileImagePath = '';
  final List<BlocksItem> blocks;
  final List<List<BlocksItem>> blocksList;
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
      String? messageError,
      Status? status,
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
      List<List<BlocksItem>>? blocksList}) {
    return EditProfileState(
      messageError: messageError ?? this.messageError,
      status: status ?? this.status,
      switchButton: switchButton ?? this.switchButton,
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
    );
  }

  @override
  List<Object?> get props => [
        messageError,
        status,
        switchButton,
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
        blockUrl,
        errorExist,
        valideName,
        userBlocks,
        blocksList,
        openDirectMeDialogue,
      ];
}
