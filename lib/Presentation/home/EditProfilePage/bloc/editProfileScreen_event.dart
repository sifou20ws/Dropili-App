part of 'editProfileScreen_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object?> get props => [];
}

class ItemSelectedEvent extends EditProfileEvent {
  final int index;
  final String data;
  final bool put;
  ItemSelectedEvent({
    required this.index,
    required this.data,
    required this.put,
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

class ActiveEvent extends EditProfileEvent {
  final bool state;
  ActiveEvent({required this.state});

  @override
  List<Object?> get props => [state];
}

class ProfileActiveEvent extends EditProfileEvent {
  final bool state;
  ProfileActiveEvent({required this.state});

  @override
  List<Object?> get props => [state];
}

class GetBlocksEvent extends EditProfileEvent {
  GetBlocksEvent();

  @override
  List<Object?> get props => [];
}

class GetUserBlocksEvent extends EditProfileEvent {
  GetUserBlocksEvent();

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
  final int width, height;
  ImportCoverImageEvent({required this.width, required this.height});

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
  final bool active;
  PostProfileUpdateEvent(
      {required this.name,
      this.active = false,
      this.description = '',
      this.profile = '',
      this.background = ''});

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

class DirectOnMeEvent extends EditProfileEvent {
  final String block_id, url;
  final bool direct;
  DirectOnMeEvent({
    required this.block_id,
    required this.direct,
    required this.url,
  });

  @override
  List<Object?> get props => [];
}

class GetCostumeBlockImage extends EditProfileEvent {
  GetCostumeBlockImage();

  @override
  List<Object?> get props => [];
}

class PostCostumeBlock extends EditProfileEvent {
  final String url, titleAr, titleFr;
  final dynamic icon;
  PostCostumeBlock({
    required this.url,
    required this.titleAr,
    this.icon,
    required this.titleFr,
  });

  @override
  List<Object?> get props => [];
}

class UpdateCostumeBlock extends EditProfileEvent {
  final String url, titleAr, titleFr, id;
  final dynamic icon;
  UpdateCostumeBlock({
    required this.id,
    required this.url,
    required this.titleAr,
    this.icon,
    required this.titleFr,
  });

  @override
  List<Object?> get props => [];
}

class GetCostumeBlocksEvent extends EditProfileEvent {
  GetCostumeBlocksEvent();

  @override
  List<Object?> get props => [];
}

class DeleteCostumeBlocksEvent extends EditProfileEvent {
  final String id;
  DeleteCostumeBlocksEvent({required this.id});

  @override
  List<Object?> get props => [];
}

class ResetCostumeBlocksEvent extends EditProfileEvent {
  ResetCostumeBlocksEvent();

  @override
  List<Object?> get props => [];
}
