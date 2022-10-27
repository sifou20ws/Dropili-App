part of 'nfc_bloc.dart';

abstract class NfcEvent extends Equatable {
  const NfcEvent();

  @override
  List<Object> get props => [];
}

class NfcTagWrittenEvent extends NfcEvent {}

class NfcStartEvent extends NfcEvent {}

class NfcTagErrorEvent extends NfcEvent {}
