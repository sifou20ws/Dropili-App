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
