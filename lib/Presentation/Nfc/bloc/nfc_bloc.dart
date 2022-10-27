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
    on<NfcTagErrorEvent>(_nfcTagErrorEvent);
    add(NfcStartEvent());
  }

  void _nfcTagFoundEvent(event, Emitter<NfcState> emit) {
    emit(NfcTagFoundState());
  }

  void _nfcTagErrorEvent(event, Emitter<NfcState> emit) {
    emit(NfcReadErrorState());
  }

  void _nfcStartEvent(evet, Emitter<NfcState> emit) async {
    var isAvailble = await NfcManager.instance.isAvailable();
    if (!isAvailble) {
      emit(NfcNotFoundState());
    } else {
      emit(NfcSearchingState());
      await NfcManager.instance.startSession(
          onDiscovered: await (tag) async {
        Ndef? ndef = Ndef.from(tag);

        if (ndef == null || !ndef.isWritable) {
          add(NfcTagErrorEvent());
          return;
        }

        NdefMessage message = NdefMessage([
          NdefRecord.createUri(Uri.parse('https://dropili.co/link/abdenourgnx'))
        ]);

        try {
          await ndef.write(message);
          add(NfcTagFoundEvent('hel'));

          return;
        } catch (e) {
          add(NfcTagErrorEvent());
        }
      });
    }

    // var status = await FlutterNfcReader.checkNFCAvailability();

    // if (status == NFCAvailability.available) {
    //   // var ndef = await FlutterNfcReader.read();
    //   NfcData result = await FlutterNfcReader.write('', '');
    //   log(result.content!);

    //   // if (ndef.content == null) {
    //   //   emit(NfcReadErrorState());
    //   // } else {
    //   //   log(ndef.content!);
    //   //   emit(NfcTagFoundState(
    //   //     ndef.content!.substring(
    //   //       ndef.content!.indexOf('www'),
    //   //     ),
    //   //   ));
    //   // }
    // } else {
    //   emit(NfcNotFoundState());
    // }
  }
}
