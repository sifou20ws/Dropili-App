part of 'nfc_bloc.dart';

abstract class NfcEvent extends Equatable {
  const NfcEvent();

  @override
  List<Object> get props => [];
}

class NfcTagFoundEvent extends NfcEvent {
  final String content;

  NfcTagFoundEvent(this.content);

  @override
  List<Object> get props => [content];
}

class NfcStartEvent extends NfcEvent {}

class NfcTagErrorEvent extends NfcEvent {}
