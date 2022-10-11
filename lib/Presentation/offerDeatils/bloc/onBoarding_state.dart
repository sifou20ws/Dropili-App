part of 'onBoarding_bloc.dart';

enum Status { initial, loading, success, fail, finish }

class OnBoardingState extends Equatable {
  OnBoardingState({
    this.messageError,
    this.status = Status.loading,
  });

  final Failure? messageError;

  final Status status;

  OnBoardingState copyWith({
    Failure? messageError,
    Status? status,
    String? id,
  }) {
    return OnBoardingState(
      messageError: messageError ?? this.messageError,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        messageError,
        status,
      ];
}
