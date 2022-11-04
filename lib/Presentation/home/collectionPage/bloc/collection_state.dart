part of 'collection_bloc.dart';

abstract class CollectionState extends Equatable {
  const CollectionState();

  @override
  List<Object> get props => [];
}

class CollectionInitial extends CollectionState {}

class CollectionLoadingState extends CollectionState {}

class CollectionLoadedState extends CollectionState {
  final String profilePicUrl;
  final String coverPicUrl;
  final List<UserBlocksItem> blocks;

  CollectionLoadedState(this.profilePicUrl, this.coverPicUrl, this.blocks);

  @override
  List<Object> get props => [profilePicUrl];
}

class CollectionErrorState extends CollectionState {}

class CollectionEmptyState extends CollectionState {}
