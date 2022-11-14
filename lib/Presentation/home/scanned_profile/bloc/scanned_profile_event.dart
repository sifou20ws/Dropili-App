part of 'scanned_profile_bloc.dart';

abstract class ScannedProfileEvent extends Equatable {
  const ScannedProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadScannedProfileEvent extends ScannedProfileEvent {
  final String scannedUrl;

  LoadScannedProfileEvent(this.scannedUrl);
  @override
  List<Object> get props => [scannedUrl];
}
