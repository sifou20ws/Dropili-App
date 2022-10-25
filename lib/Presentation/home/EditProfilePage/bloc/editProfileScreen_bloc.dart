
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dropili/Presentation/widgets_model/icons_lists.dart';
import 'package:dropili/domain/repositories/edit_profile_repository.dart';
import 'package:equatable/equatable.dart';

import 'package:dropili/core/error/failure.dart';

part 'editProfileScreen_event.dart';
part 'editProfileScreen_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc({required EditProfileRepository editProfileRepository})
      : _editProfileRepository = editProfileRepository ,
        super(EditProfileState()){
    on<ItemSelectedEvent> (_itemSelectedEvent);
    on<SwitchEvent> (_switchEvent);

  }
  EditProfileRepository _editProfileRepository;


  void _itemSelectedEvent(ItemSelectedEvent event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(index: event.index));
    log(IconsLists.contactItems[event.index].selected.toString());

    IconsLists.allItems[event.index].selected= !IconsLists.allItems[event.index].selected ;
      //log('value received');
    log(IconsLists.contactItems[event.index].selected.toString());
  }

  void _switchEvent(SwitchEvent event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(switchButton: event.state));
  }



}
