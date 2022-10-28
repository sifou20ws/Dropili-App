
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dropili/data/models/get_blocks_model.dart';
import 'package:dropili/data/models/post_user_blocks.dart';
import 'package:dropili/domain/repositories/edit_profile_repository.dart';
import 'package:equatable/equatable.dart';

import 'package:dropili/core/error/failure.dart';

part 'editProfileScreen_event.dart';
part 'editProfileScreen_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileRepository _editProfileRepository;
  EditProfileBloc({required EditProfileRepository editProfileRepository})
      : _editProfileRepository = editProfileRepository ,
        super(EditProfileState(blocks: [])){
    on<ItemSelectedEvent> (_itemSelectedEvent);
    on<SwitchEvent> (_switchEvent);
    on<GetBlocksEvent> (_getBlocks);

  }

  void _getBlocks(GetBlocksEvent event, Emitter<EditProfileState> emit)async {
    emit(state.copyWith(status: Status.loading));
    var resp;
    try{
      resp = await  _editProfileRepository.getBlocks();
      emit(state.copyWith(status: Status.getSuccess));
      emit(state.copyWith(blocks: resp));
      log(resp[0].title.fr.toString());
    }catch(e){
      emit(state.copyWith(status: Status.fail));
      log(('error :'));
      log(e.toString());
    }

  }

  void _itemSelectedEvent(ItemSelectedEvent event, Emitter<EditProfileState> emit) async {
    emit(state.copyWith(index: event.index));
    emit(state.copyWith(status: Status.loading));
    var resp;
    try{
      log(event.index.toString());
      PostUserBlocks data = PostUserBlocks(id: event.index+1 , url: event.data);
      resp = await  _editProfileRepository.PostUserBlocks(data.toJson());
      emit(state.copyWith(status: Status.getSuccess));
      //emit(state.copyWith(blocks: resp));
      log(resp.toString());
    }catch(e){
      emit(state.copyWith(status: Status.fail));
      log(('error :'));
      log(e.toString());
    }
    //log(state.blocks[event.index].title.ar);


  }

  void _switchEvent(SwitchEvent event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(switchButton: event.state));
  }




}
