part of 'editProfileScreen_bloc.dart';

enum Status { initial, loading, success, fail, finish , getSuccess}

class EditProfileState extends Equatable {
  EditProfileState({
    this.switchButton = false,
    this.messageError,
    this.status = Status.loading,
    this.id = '',
    this.index = -1,
    required this.blocks ,
  });

  final Failure? messageError;
  final Status status;
  final bool switchButton;
  final String id;
  final int index;

  final List<BlocksItem> blocks;

  EditProfileState copyWith({
    bool? switchButton,
    Failure? messageError,
    Status? status,
    String? id,
    int? index,
    List<BlocksItem>? blocks,
  }) {
    return EditProfileState(
      messageError: messageError ?? this.messageError,
      status: status ?? this.status,
      switchButton: switchButton ?? this.switchButton,
      id: id ?? this.id,
      index: index ?? this.index,
      blocks: blocks ?? this.blocks,
    );
  }

  @override
  List<Object?> get props => [messageError, status, switchButton, id, index , blocks];
}
