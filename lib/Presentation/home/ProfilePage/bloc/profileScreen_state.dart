part of 'profileScreen_bloc.dart';

enum ProfileStatus {
  initial,
  loading,
  success,
  fail,
  finish,
  getSuccess,
  loadingBlocks,
  getBlocksSuccess,

  getCostumeBlocks,
  getCostumeBlocksSuccess,
  getCostumeBlocksFail,
}

class ProfileState extends Equatable {
  ProfileState({
    this.messageError = '',
    this.status = ProfileStatus.loading,
    required this.userBlocks,
    required this.costumeBlocks,
    this.showProfile,
    this.linkCopied = false,
  });

  final String messageError;

  final ProfileStatus status;
  final List<List<UserBlocksItem>> userBlocks;
  final List<CustomBlocksItem> costumeBlocks;
  PostProfileResp? showProfile;

  final bool linkCopied;
  ProfileState copyWith({
    String? messageError,
    ProfileStatus? status,
    String? id,
    List<List<UserBlocksItem>>? userBlocks,
    PostProfileResp? showProfile,
    List<BlocksItem>? blocks,
    List<CustomBlocksItem>? costumeBlocks,
    bool? linkCopied,
  }) {
    return ProfileState(
      messageError: messageError ?? this.messageError,
      status: status ?? this.status,
      userBlocks: userBlocks ?? this.userBlocks,
      showProfile: showProfile ?? this.showProfile,
      costumeBlocks: costumeBlocks ?? this.costumeBlocks,
      linkCopied: linkCopied ?? this.linkCopied,
    );
  }

  @override
  List<Object?> get props => [
        messageError,
        status,
        userBlocks,
        showProfile,
        costumeBlocks,
        linkCopied,
      ];
}
