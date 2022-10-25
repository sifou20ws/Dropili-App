part of 'editProfileScreen_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object?> get props => [];
}

class ItemSelectedEvent extends EditProfileEvent {
  final int index;

  ItemSelectedEvent({required this.index});

  @override
  List<Object?> get props => [index];

}

class SwitchEvent extends EditProfileEvent {
  final bool state ;

  SwitchEvent({required this.state});

  @override
  List<Object?> get props => [state];
}



