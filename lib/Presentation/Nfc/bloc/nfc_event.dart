part of 'nfc_bloc.dart';

abstract class NfcEvent extends Equatable {
  const NfcEvent();

  @override
  List<Object> get props => [];
}

class NfcTagWrittenEvent extends NfcEvent {}

class WriteTagEvent extends NfcEvent {
  final String url;

  WriteTagEvent(this.url);

  @override
  List<Object> get props => [url];
}

class ReadTagEvent extends NfcEvent {}

class TagReadSucessEvent extends NfcEvent {
  final String url;

  TagReadSucessEvent(this.url);

  @override
  List<Object> get props => [url];

}

class NfcTagErrorEvent extends NfcEvent {}
