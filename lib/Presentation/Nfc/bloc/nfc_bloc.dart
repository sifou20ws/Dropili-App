import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nfc_manager/nfc_manager.dart';

part 'nfc_event.dart';
part 'nfc_state.dart';

class NfcBloc extends Bloc<NfcEvent, NfcState> {
  NfcBloc() : super(NfcSearchingState()) {
    on<NfcTagWrittenEvent>(_NfcTagWrittenEvent);
    on<WriteTagEvent>(_WriteTagEvent);
    on<NfcTagErrorEvent>(_nfcTagErrorEvent);
    on<ReadTagEvent>(_readTagEvent);
    on<TagReadSucessEvent>(_tagReadSucessEvent);
  }

  void _NfcTagWrittenEvent(event, Emitter<NfcState> emit) {
    emit(NfcTagWrittenState());
  }

  void _nfcTagErrorEvent(event, Emitter<NfcState> emit) {
    emit(NfcWriteErrorState());
  }

  void _tagReadSucessEvent(event, Emitter<NfcState> emit) {
    emit(
      NfcReadSuccess(
        event.url,
      ),
    );
  }

  void _WriteTagEvent(event, Emitter<NfcState> emit) async {
    emit(NfcSearchingState());
    var isAvailble = await NfcManager.instance.isAvailable();

    if (!isAvailble) {
      emit(NfcNotFoundState());
    } else {
      NfcManager.instance.stopSession();
      emit(NfcSearchingState());
      await NfcManager.instance.startSession(
          onDiscovered: await (tag) async {
        Ndef? ndef = Ndef.from(tag);

        if (ndef == null || !ndef.isWritable) {
          add(NfcTagErrorEvent());
          return;
        }

        NdefMessage message = NdefMessage([
          NdefRecord.createUri(Uri.parse(event.url)),
        ]);

        try {
          await ndef.write(message);
          add(NfcTagWrittenEvent());

          return;
        } catch (e) {
          add(NfcTagErrorEvent());
        }
      });
    }
  }

  void _readTagEvent(event, Emitter<NfcState> emit) async {
    log(name: 'NFC', 'reading');
    var isAvailble = await NfcManager.instance.isAvailable();

    if (!isAvailble) {
      emit(NfcNotFoundState());
    } else {
      emit(NfcSearchingState());
      await NfcManager.instance.startSession(
          onDiscovered: await (NfcTag tag) async {
        Ndef? ndef = Ndef.from(tag);

        if (ndef == null) {
          add(NfcTagErrorEvent());
          return;
        }

        final data = await ndef.read();
        add(
          TagReadSucessEvent(
            utf8.decode(data.records.first.payload).substring(1),
          ),
        );
      });
    }
  }
}
