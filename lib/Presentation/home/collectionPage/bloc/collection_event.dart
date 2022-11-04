part of 'collection_bloc.dart';

abstract class CollectionEvent extends Equatable {
  const CollectionEvent();

  @override
  List<Object> get props => [];
}

class LoadCollectionEvent extends CollectionEvent {}

class DeleteFriendEvent extends CollectionEvent {}
