import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc()
      : super(NavigationState(currentPage: Pages.profile, index: 0)) {
    on<NavigationEvent>((event, emit) {
      switch (event.index) {
        case 0:
          emit(NavigationState(index: event.index, currentPage: Pages.profile));
          break;
        case 1:
          emit(NavigationState(index: event.index, currentPage: Pages.scanner));
          break;
        case 2:
          emit(NavigationState(index: event.index, currentPage: Pages.qr));
          break;
        case 3:
          emit(NavigationState(
              index: event.index, currentPage: Pages.collection));
          break;
        default:
          return;
      }
    });
  }
}
