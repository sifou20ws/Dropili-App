part of 'editProfileScreen_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object?> get props => [];
}

class ItemSelectedEvent extends EditProfileEvent {
  final int index;
  final String data;
  ItemSelectedEvent({
    required this.index,
    required this.data,
  });

  @override
  List<Object?> get props => [index];
}

class SwitchEvent extends EditProfileEvent {
  final bool state;
  SwitchEvent({required this.state});

  @override
  List<Object?> get props => [state];
}

class GetBlocksEvent extends EditProfileEvent {
  GetBlocksEvent();

  @override
  List<Object?> get props => [];
}

class PostBlocksEvent extends EditProfileEvent {
  final data;
  PostBlocksEvent(this.data);

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

class PostUserNameEvent extends EditProfileEvent {
  final String name;
  PostUserNameEvent({required this.name});

  @override
  List<Object?> get props => [];
}

class PostDescriptionEvent extends EditProfileEvent {
  final String description;
  PostDescriptionEvent({required this.description});

  @override
  List<Object?> get props => [];
}

class PostProfileUpdateEvent extends EditProfileEvent {
  final String name, description;
  final String profile, background;
  PostProfileUpdateEvent(
      {required this.name,
        this.description = '',
        this.profile='',
        this.background=''});

  @override
  List<Object?> get props => [];
}

class GetProfileEvent extends EditProfileEvent {

  GetProfileEvent();

  @override
  List<Object?> get props => [];
}

class BlockUrlEvent extends EditProfileEvent {
  final String url;
  BlockUrlEvent(this.url);

  @override
  List<Object?> get props => [];
}

class DeleteUserBlocksEvent extends EditProfileEvent {
  final String id;
  DeleteUserBlocksEvent({required this.id});

  @override
  List<Object?> get props => [];
}
