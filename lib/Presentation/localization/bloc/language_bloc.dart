import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:dropili/common/constant/languages.dart';
import 'package:dropili/domain/entities/language_entity.dart';
import 'package:equatable/equatable.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc()
      : super(
          LanguageLoaded(
            Locale(Languages.languages[0].code),
          ),
        ) {
    on<ToggleLanguageEvent>(_toggleLanguageEvent);
  }

  void _toggleLanguageEvent(event, Emitter<LanguageState> emit) {
    emit(LanguageLoaded(Locale(event.language.code)));
  }
}
