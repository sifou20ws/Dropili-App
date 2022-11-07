part of 'editProfileScreen_bloc.dart';

enum Status {
  initial,
  loading,
  success,
  fail,
  finish,
  getProfileSuccess,
  getBlocksSuccess,
  loadingBlocks,
  loadingProfile,
  postBlockLoading,
  postBlockSuccess,
  deleteLoading,
  deleteSuccess,
  loadingProfileUpdate,
  profileUpdateSucess
}

class EditProfileState extends Equatable {
  EditProfileState(
      {this.switchButton = false,
      this.messageError = '',
      this.errorExist = false,
      this.status = Status.loading,
      this.id = '',
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
      this.valideName = true,
        this.load = false,
      this.blockUrl = ''});

  final bool errorExist;
  bool load ;
  final String messageError;
  final Status status;
  final bool switchButton;
  final String id;
  final int index;
  String coverImagePath = '';
  String profileImagePath = '';
  final List<BlocksItem> blocks;
  final String userName;
  final String userDescription;
  final String backgroundImg;
  final String profileImg;
  final PostProfileResp? showProfile;
  final String blockUrl;
  final bool valideName;
  final List<UserBlocksItem> userBlocks;

  EditProfileState copyWith(
      {bool? switchButton,
      String? messageError,
      Status? status,
      String? id,
      int? index,
      List<BlocksItem>? blocks,
      String? coverImagePath,
      String? profileImagePath,
      String? backgroundImg,
      String? profileImg,
      String? userName,
      String? userDescription,
      PostProfileResp? showProfile,
      String? blockUrl,
      bool? errorExist,
      bool? valideName,
        bool?load,
      List<UserBlocksItem>? userBlocks}) {
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
      valideName: valideName ?? this.valideName,
      userBlocks: userBlocks ?? this.userBlocks,
      load:load??this.load,
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
        userName,
        userDescription,
        profileImg,
        backgroundImg,
        showProfile,
        blockUrl,
        errorExist,
        valideName,
        userBlocks
      ];
}
