part of 'profileScreen_bloc.dart';

enum ProfileStatus { initial, loading, success, fail, finish, getSuccess }

class ProfileState extends Equatable {
  ProfileState({
    this.messageError,
    this.status = ProfileStatus.loading,
    required this.userBlocks,
  });

  final Failure? messageError;

  final ProfileStatus status;
  final List<UserBlocksItem> userBlocks;
  ProfileState copyWith({
    Failure? messageError,
    ProfileStatus? status,
    String? id,
    List<UserBlocksItem>? userBlocks,
  }) {
    return ProfileState(
      messageError: messageError ?? this.messageError,
      status: status ?? this.status,
      userBlocks: userBlocks ?? this.userBlocks,
    );
  }

  @override
  List<Object?> get props => [
        messageError,
        status,
        userBlocks,
      ];
}
