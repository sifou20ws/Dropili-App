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
}

class ProfileState extends Equatable {
  ProfileState({
    this.messageError,
    this.status = ProfileStatus.loading,
    required this.userBlocks,
    this.showProfile,
    this.blocks,
  });

  final Failure? messageError;

  final ProfileStatus status;
  final List<UserBlocksItem> userBlocks;
  List<BlocksItem>? blocks;
  PostProfileResp? showProfile;

  ProfileState copyWith({
    Failure? messageError,
    ProfileStatus? status,
    String? id,
    List<UserBlocksItem>? userBlocks,
    PostProfileResp? showProfile,
    List<BlocksItem>? blocks,
  }) {
    return ProfileState(
      messageError: messageError ?? this.messageError,
      status: status ?? this.status,
      userBlocks: userBlocks ?? this.userBlocks,
      showProfile: showProfile ?? this.showProfile,
      blocks: blocks ?? this.blocks,
    );
  }

  @override
  List<Object?> get props => [
        messageError,
        status,
        userBlocks,
        showProfile,
        blocks,
      ];
}
