import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dropili/core/error/failure.dart';
import 'package:dropili/data/models/get_friends_result_model.dart.dart';
import 'package:dropili/domain/repositories/edit_profile_repository.dart';
import 'package:equatable/equatable.dart';

part 'collection_event.dart';
part 'collection_state.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  final EditProfileRepository editProfileRepository;

  CollectionBloc({required EditProfileRepository editProfileRepository})
      : this.editProfileRepository = editProfileRepository,
        super(CollectionLoadingState()) {
    on<LoadCollectionEvent>(_loadCollection);
    on<DeleteFriendEvent>(_deleteFriendEvent);

    add(LoadCollectionEvent());
  }

  void _loadCollection(event, Emitter<CollectionState> emit) async {
    emit(CollectionLoadingState());
    List<FriendsItem> friendsList;
    try {
      friendsList = await editProfileRepository.getFriends();

      if (friendsList.length == 0) {
        emit(CollectionEmptyState());
      } else {
        emit(CollectionLoadedState(friendsList));
      }
    } on Failure catch (f) {
      emit(CollectionErrorState(f.message));
    } catch (e) {
      emit(CollectionErrorState(e.toString()));
    }
  }

  void _deleteFriendEvent(event, Emitter<CollectionState> emit) async {
    try {
      if (await editProfileRepository.deleteFriend(event.id)) {
        emit(CollectionSucessState('Deleted sucessfully'));
        add(LoadCollectionEvent());
      } else {
        emit(CollectionErrorState('Couldnt delete friend'));
      }
    } on Failure catch (f) {
      emit(CollectionErrorState(f.message));
    } catch (e) {
      emit(CollectionErrorState(e.toString()));
    }
  }
}
