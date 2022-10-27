part of 'profileScreen_bloc.dart';

enum ProfileStatus { initial, loading, success, fail, finish }

class ProfileState extends Equatable {
  ProfileState({
    this.messageError,
    this.status = ProfileStatus.loading,
  });

  final Failure? messageError;

  final ProfileStatus status;

  ProfileState copyWith({
    Failure? messageError,
    ProfileStatus? status,
    String? id,
  }) {
    return ProfileState(
      messageError: messageError ?? this.messageError,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        messageError,
        status,
      ];
}
