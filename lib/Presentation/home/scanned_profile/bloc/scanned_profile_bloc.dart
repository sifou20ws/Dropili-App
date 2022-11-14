import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dropili/core/error/failure.dart';
import 'package:dropili/data/models/get_blocks_model.dart';
import 'package:dropili/data/models/get_friends_result_model.dart.dart';
import 'package:dropili/domain/repositories/profile_repository.dart';
import 'package:equatable/equatable.dart';

part 'scanned_profile_event.dart';
part 'scanned_profile_state.dart';

class ScannedProfileBloc
    extends Bloc<ScannedProfileEvent, ScannedProfileState> {
  final ProfileRepository _profileRepository;

  ScannedProfileBloc({required ProfileRepository profileRepository})
      : this._profileRepository = profileRepository,
        super(ProfileLoadingState()) {
    on<LoadScannedProfileEvent>(_loadScannedProfileEvent);
  }

  void _loadScannedProfileEvent(
      event, Emitter<ScannedProfileState> emit) async {
    emit(ProfileLoadingState());

    late int userId;
    String username = event.scannedUrl.toString().split('/').last;
    List<FriendsItem> friendsList;
    FriendsItem selectedProfile;

    try {
      userId = await _profileRepository.getIdFromUsername(username);

      log(userId.toString());

      await _profileRepository.addFriend(userId);

      friendsList = await _profileRepository.getFriends();

      selectedProfile =
          friendsList.singleWhere((element) => element.id == userId);


      List<List<UserBlocksItem>> blocksTypesList = [
        selectedProfile.blocks.where((element) => element.type == 1).toList(),
        selectedProfile.blocks.where((element) => element.type == 2).toList(),
        selectedProfile.blocks.where((element) => element.type == 3).toList(),
        selectedProfile.blocks.where((element) => element.type == 4).toList(),
      ]..removeWhere((element) => element.isEmpty);

      emit(
        ProfileLoadedState(
          selectedProfile,
          blocksTypesList,
        ),
      );
    } on Failure catch (f) {
      log(f.message);
      emit(LoadingErrorState(f.message));
    } catch (e) {
      log(e.toString());
      emit(LoadingErrorState(e.toString()));
    }
  }
}
