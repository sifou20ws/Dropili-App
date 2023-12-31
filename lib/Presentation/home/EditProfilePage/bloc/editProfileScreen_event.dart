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
  final String block_id, url , direct;
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

class GetCostumeBlockFile extends EditProfileEvent {
  GetCostumeBlockFile();

  @override
  List<Object?> get props => [];
}

class PostCostumeBlock extends EditProfileEvent {
  final String titleAr;
  final dynamic icon, file, url;
  final bool fileOrUrl;
  PostCostumeBlock(
      {this.url,
      required this.fileOrUrl,
      required this.titleAr,
      this.icon,
      this.file});

  @override
  List<Object?> get props => [];
}

class UpdateCostumeBlock extends EditProfileEvent {
  final String title, id;
  final dynamic icon, file, url, fileName;
  final bool urlOrFile;
  UpdateCostumeBlock({
    required this.id,
    this.url = '',
    required this.title,
    this.icon = '',
    this.file = '',
    this.fileName = '',
    this.urlOrFile = true,
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

class CostumeFileEvent extends EditProfileEvent {
  CostumeFileEvent();

  @override
  List<Object?> get props => [];
}

class CostumeUrlEvent extends EditProfileEvent {
  CostumeUrlEvent();

  @override
  List<Object?> get props => [];
}

class CostumeUrlOrFileEvent extends EditProfileEvent {
  final int? state ;
  CostumeUrlOrFileEvent({required this.state});

  @override
  List<Object?> get props => [];
}
