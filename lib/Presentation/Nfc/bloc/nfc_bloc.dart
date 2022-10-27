import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nfc_manager/nfc_manager.dart';

part 'nfc_event.dart';
part 'nfc_state.dart';

class NfcBloc extends Bloc<NfcEvent, NfcState> {
  final String dataToTag;

  NfcBloc(this.dataToTag) : super(NfcSearchingState()) {
    on<NfcTagWrittenEvent>(_NfcTagWrittenEvent);
    on<NfcStartEvent>(_nfcStartEvent);
    on<NfcTagErrorEvent>(_nfcTagErrorEvent);
    add(NfcStartEvent());
  }

  void _NfcTagWrittenEvent(event, Emitter<NfcState> emit) {
    emit(NfcTagWrittenState());
  }

  void _nfcTagErrorEvent(event, Emitter<NfcState> emit) {
    emit(NfcWriteErrorState());
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
          NdefRecord.createUri(Uri.parse(dataToTag)),
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
}
