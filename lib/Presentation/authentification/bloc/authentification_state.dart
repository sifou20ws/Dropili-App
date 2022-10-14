part of 'authentification_bloc.dart';

abstract class AuthentificationState extends Equatable {
  const AuthentificationState();
  
  @override
  List<Object> get props => [];
}

class AuthentificationInitial extends AuthentificationState {}
