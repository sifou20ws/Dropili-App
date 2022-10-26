import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nfc_manager/nfc_manager.dart';

part 'nfc_event.dart';
part 'nfc_state.dart';

class NfcBloc extends Bloc<NfcEvent, NfcState> {
  NfcBloc() : super(NfcSearchingState()) {
    on<NfcTagFoundEvent>(_nfcTagFoundEvent);
    on<NfcStartEvent>(_nfcStartEvent);
  }

  void _nfcTagFoundEvent(event, Emitter<NfcState> emit) {
    emit(NfcFoundState(event.content));
    // emit(NfcErroState());
  }

  void _nfcStartEvent(evet, Emitter<NfcState> emit) async {
    log('nfc starting');
    var isAvailable = await NfcManager.instance.isAvailable();
    if (isAvailable) {
      log('not avail');
      emit(NfcErroState());
    } else {
      log('now waiting datat');
      unawaited(
        NfcManager.instance.startSession(
          onDiscovered: (tag) async {
            var ndef = Ndef.from(tag);
            var record = ndef!.cachedMessage!.records.first;
            var patload = ascii.decode(record.payload);
            add(NfcTagFoundEvent(patload));
          },
        ),
      );
      // emit(NfcFoundState('TAG'));
    }
  }
}
