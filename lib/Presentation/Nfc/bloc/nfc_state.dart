part of 'nfc_bloc.dart';

abstract class NfcState extends Equatable {
  const NfcState();

  @override
  List<Object> get props => [];
}

class NfcSearchingState extends NfcState {}

class NfcFoundState extends NfcState {
  final String content;

  NfcFoundState(this.content);

  @override
  List<Object> get props => [content];
}

class NfcErroState extends NfcState {}
