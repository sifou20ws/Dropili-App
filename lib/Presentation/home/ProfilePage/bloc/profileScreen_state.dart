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
    this.messageError = '',
    this.status = ProfileStatus.loading,
    required this.userBlocks,
    this.showProfile,
  });

  final String messageError;

  final ProfileStatus status;
  final List<List<UserBlocksItem>> userBlocks;
  PostProfileResp? showProfile;

  ProfileState copyWith({
    String? messageError,
    ProfileStatus? status,
    String? id,
    List<List<UserBlocksItem>>? userBlocks,
    PostProfileResp? showProfile,
    List<BlocksItem>? blocks,
  }) {
    return ProfileState(
      messageError: messageError ?? this.messageError,
      status: status ?? this.status,
      userBlocks: userBlocks ?? this.userBlocks,
      showProfile: showProfile ?? this.showProfile,
    );
  }

  @override
  List<Object?> get props => [
        messageError,
        status,
        userBlocks,
        showProfile,
      ];
}
