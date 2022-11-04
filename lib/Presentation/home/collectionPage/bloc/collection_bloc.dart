import 'package:bloc/bloc.dart';
import 'package:dropili/data/models/get_blocks_model.dart';
import 'package:dropili/data/models/post_user_profile_response.dart';
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

    add(LoadCollectionEvent());
  }

  void _loadCollection(event, Emitter<CollectionState> emit) async {
    emit(CollectionLoadingState());
    PostProfileResp profileResp;
    List<UserBlocksItem> blocks;
    try {
      profileResp = await editProfileRepository.getProfileShow();
      blocks = await editProfileRepository.getUserBlocks();

      emit(CollectionLoadedState(profileResp.user.userProfile.originalUrl,
          profileResp.user.name, blocks));
      //log(resp.toString());
    } catch (e) {
      emit(CollectionErrorState());
    }
  }
}
