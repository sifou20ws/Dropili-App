part of 'navigation_bloc.dart';

enum Pages { profile, scanner, qr, collection }

class NavigationState extends Equatable {
  final int index;
  final Pages currentPage;

  const NavigationState({this.index = 0, this.currentPage = Pages.profile});

  @override
  List<Object> get props => [index, currentPage];
}
