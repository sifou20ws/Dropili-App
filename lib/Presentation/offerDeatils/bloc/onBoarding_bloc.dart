import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../domain/usecases/onBoardingUsecase.dart';

part 'onBoarding_event.dart';
part 'onBoarding_state.dart';

class OnBoardingBloc extends Bloc<OnBoardingEvent, OnBoardingState> {
  OnBoardingBloc({required OfferDetailsUsseCasse offerDetailsUsseCasse})
      : _getffreUseCase = offerDetailsUsseCasse,
        super(OnBoardingState());

  OfferDetailsUsseCasse _getffreUseCase;
}
