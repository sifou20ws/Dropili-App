part of 'profileScreen_bloc.dart';

enum ProfileStatus { initial, loading, success, fail, finish, getSuccess }

class ProfileState extends Equatable {
  ProfileState({
    this.messageError,
    this.status = ProfileStatus.loading,
    required this.blocks,
  });

  final Failure? messageError;

  final ProfileStatus status;
  final List<String> blocks;

  ProfileState copyWith({
    Failure? messageError,
    ProfileStatus? status,
    String? id,
    List<String>? blocks,
  }) {
    return ProfileState(
      messageError: messageError ?? this.messageError,
      status: status ?? this.status,
      blocks: blocks ?? this.blocks,
    );
  }

  @override
  List<Object?> get props => [
        messageError,
        status,
        blocks,
      ];
}
