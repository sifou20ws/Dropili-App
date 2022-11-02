part of 'profileScreen_bloc.dart';

enum ProfileStatus { initial, loading, success, fail, finish, getSuccess }

class ProfileState extends Equatable {
  ProfileState({
    this.messageError,
    this.status = ProfileStatus.loading,
    required this.userBlocks,
    this.showProfile,
  });

  final Failure? messageError;

  final ProfileStatus status;
  final List<UserBlocksItem> userBlocks;
  PostProfileResp? showProfile;

  ProfileState copyWith({
    Failure? messageError,
    ProfileStatus? status,
    String? id,
    List<UserBlocksItem>? userBlocks,
    PostProfileResp? showProfile,
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
