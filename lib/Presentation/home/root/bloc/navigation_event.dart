part of 'navigation_bloc.dart';

class NavigationEvent extends Equatable {
  final int index;
  const NavigationEvent(this.index);

  @override
  List<Object> get props => [index];
}
