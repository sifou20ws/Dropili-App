import 'package:bloc/bloc.dart';
import 'package:dropili/data/models/get_blocks_model.dart';
import 'package:dropili/data/models/get_costume_block_response.dart';
import 'package:dropili/data/models/post_user_profile_response.dart';
import 'package:dropili/domain/repositories/profile_repository.dart';
import 'package:equatable/equatable.dart';

part 'profileScreen_event.dart';
part 'profileScreen_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileRepository _ProfileRepository;
  ProfileBloc({required ProfileRepository ProfileRepository})
      : _ProfileRepository = ProfileRepository,
        super(ProfileState(userBlocks: [], costumeBlocks: [])) {
    on<EditButtonClickedEvent>(_editButtonClickedEvent);
    on<GetUserBlocksEvent>(_getUserBlocksEvent);
    on<GetProfileEvent>(_getProfileEvent);
    on<GetCostumeBlocksEvent>(_getCostumeBlocksEvent);
    on<GetEverytihngEvent>(_getEverything);
    add(GetUserBlocksEvent());
    add(GetProfileEvent());
  }

  void _editButtonClickedEvent(event, Emitter<ProfileState> emit) {
    emit(state.copyWith(status: ProfileStatus.success));
  }

  void _getEverything(event, Emitter<ProfileState> emit) {
    add(GetProfileEvent());
    add(GetUserBlocksEvent());
    add(GetCostumeBlocksEvent());
  }

  void _getUserBlocksEvent(event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    List<List<UserBlocksItem>>? userBlocksLists;
    try {
      var resp = await _ProfileRepository.getUserBlocks();

      userBlocksLists = [
        resp.where((element) => element.type == 1).toList(),
        resp.where((element) => element.type == 2).toList(),
        resp.where((element) => element.type == 3).toList(),
        resp.where((element) => element.type == 4).toList(),
      ]..removeWhere((element) => element.isEmpty);

      emit(state.copyWith(userBlocks: userBlocksLists));
      emit(state.copyWith(status: ProfileStatus.getSuccess));
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.fail,
          messageError: e.toString(),
        ),
      );
    }
  }

  void _getProfileEvent(
      GetProfileEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    var resp;
    try {
      resp = await _ProfileRepository.getProfileShow();
      emit(state.copyWith(showProfile: resp));
      emit(state.copyWith(status: ProfileStatus.getSuccess));
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.fail,
          messageError: e.toString(),
        ),
      );
    }
  }

  void _getCostumeBlocksEvent(
      GetCostumeBlocksEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: ProfileStatus.getCostumeBlocks));
    GetCostumeBlocksResponse resp;
    final List<CustomBlocksItem> costumeBlocks;

    try {
      resp = await _ProfileRepository.getCostumeBlocks();
      costumeBlocks = resp.customBlocks;

      emit(state.copyWith(
        costumeBlocks: costumeBlocks,
        status: ProfileStatus.getCostumeBlocksSuccess,
      ));

      //log(costumeBlocks[2].icon.toString());
      //log(state.userBlocks.toString(), name: 'UBL in bloc');
    } catch (e) {
      emit(state.copyWith(status: ProfileStatus.getCostumeBlocksFail));
      // log(('error :'));
      // log(e.toString());
    }
  }
}
