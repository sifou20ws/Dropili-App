part of 'nfc_bloc.dart';

abstract class NfcState extends Equatable {
  const NfcState();

  @override
  List<Object> get props => [];
}

class NfcSearchingState extends NfcState {}

class NfcNotFoundState extends NfcState {}

class NfcTagFoundState extends NfcState {}

class NfcReadErrorState extends NfcState {}
