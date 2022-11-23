part of 'profileScreen_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class EditButtonClickedEvent extends ProfileEvent {}

class GetUserBlocksEvent extends ProfileEvent {

  GetUserBlocksEvent();

  @override
  List<Object?> get props => [];
}

class GetProfileEvent extends ProfileEvent {

  GetProfileEvent();

  @override
  List<Object?> get props => [];
}

class DeleteUserBlocksEvent extends ProfileEvent {
  final String id;
  DeleteUserBlocksEvent({required this.id});

  @override
  List<Object?> get props => [];
}

class GetCostumeBlocksEvent extends ProfileEvent {
  GetCostumeBlocksEvent();

  @override
  List<Object?> get props => [];
}
