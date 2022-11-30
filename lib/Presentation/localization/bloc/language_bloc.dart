import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:dropili/common/constant/languages.dart';
import 'package:dropili/core/utils/storage.dart';
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
    on<InitialLanguaheEven>(_initLangEvent);

    add(InitialLanguaheEven());
  }

  void _toggleLanguageEvent(event, Emitter<LanguageState> emit) async {
    await LocalStorageHandler.storeCurrentLanguage(event.language.code);
    emit(LanguageLoaded(Locale(event.language.code)));
  }

  void _initLangEvent(event, Emitter<LanguageState> emit) async {
    emit(LanguageLoaded(
      Locale(
        await Languages.initialLanguage(),
      ),
    ));
  }
}
