part of 'editProfileScreen_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object?> get props => [];
}

class ItemSelectedEvent extends EditProfileEvent {
  final int index;
  final String data;
  ItemSelectedEvent( {required this.index , required this.data, });

  @override
  List<Object?> get props => [index];

}

class SwitchEvent extends EditProfileEvent {
  final bool state ;
  SwitchEvent({required this.state});

  @override
  List<Object?> get props => [state];
}

class GetBlocksEvent extends EditProfileEvent {
  GetBlocksEvent();

  @override
  List<Object?> get props => [];
}

class ImportCoverImageEvent extends EditProfileEvent {
  ImportCoverImageEvent();

  @override
  List<Object?> get props => [];
}

class ImportProfileImageEvent extends EditProfileEvent {
  ImportProfileImageEvent();

  @override
  List<Object?> get props => [];
}