
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dropili/Presentation/widgets_model/icons_lists.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../domain/usecases/editProfileUsecase.dart';

part 'editProfileScreen_event.dart';
part 'editProfileScreen_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc({required EditProfileUseCase editProfileUseCase})
      : _editProfileUseCase = editProfileUseCase ,
        super(EditProfileState()){
    on<ItemSelectedEvent> (_itemSelectedEvent);
    on<SwitchEvent> (_switchEvent);

  }
  EditProfileUseCase _editProfileUseCase;


  void _itemSelectedEvent(ItemSelectedEvent event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(index: event.index));

      IconsLists.allItems[event.index].selected= !IconsLists.contactItems[event.index].selected ;
      log('value received');
    //  log(IconsLists.contactItems[event.index].selected.toString());*/
  }

  void _switchEvent(SwitchEvent event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(switchButton: event.state));
  }



}
