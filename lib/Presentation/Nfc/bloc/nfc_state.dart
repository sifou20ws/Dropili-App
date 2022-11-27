part of 'nfc_bloc.dart';

abstract class NfcState extends Equatable {
  const NfcState();

  @override
  List<Object> get props => [];
}

class NfcSearchingState extends NfcState {}

class NfcNotFoundState extends NfcState {}

class NfcTagWrittenState extends NfcState {}

class NfcWriteErrorState extends NfcState {}

class NfcReadSuccess extends NfcState {
  final String content;

  NfcReadSuccess(this.content);

  @override
  List<Object> get props => [content];
}
