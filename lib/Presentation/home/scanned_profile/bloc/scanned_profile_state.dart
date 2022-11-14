part of 'scanned_profile_bloc.dart';

abstract class ScannedProfileState extends Equatable {
  const ScannedProfileState();

  @override
  List<Object> get props => [];
}

class ProfileLoadingState extends ScannedProfileState {}

class ProfileLoadedState extends ScannedProfileState {
  final FriendsItem scannedFriend;
  List<List<UserBlocksItem>> blocksTypesList;

  ProfileLoadedState(this.scannedFriend, this.blocksTypesList);

  @override
  List<Object> get props => [scannedFriend];
}

class LoadingErrorState extends ScannedProfileState {
  final String errorMassage;

  LoadingErrorState(this.errorMassage);

  @override
  List<Object> get props => [errorMassage];
}
