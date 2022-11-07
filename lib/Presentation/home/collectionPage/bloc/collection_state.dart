part of 'collection_bloc.dart';

abstract class CollectionState extends Equatable {
  const CollectionState();

  @override
  List<Object> get props => [];
}

class CollectionInitial extends CollectionState {}

class CollectionLoadingState extends CollectionState {}

class CollectionLoadedState extends CollectionState {
  final List<FriendsItem> friendsList;

  CollectionLoadedState(this.friendsList);

  @override
  List<Object> get props => [friendsList];
}

class CollectionErrorState extends CollectionState {
  final String errorMassage;

  CollectionErrorState(this.errorMassage);

  @override
  List<Object> get props => [errorMassage];
}
class CollectionSucessState extends CollectionState {
  final String message;

  CollectionSucessState(this.message);

  @override
  List<Object> get props => [message];
}


class CollectionEmptyState extends CollectionState {}
