import 'package:dream_messenger_demo/core/failure/failure.dart';

abstract class SignInState {}

class SignInInitialState extends SignInState{}

class SignInLoadingState extends SignInState {}

class SignInFailedState extends SignInState {
  final Failure failure;

  SignInFailedState({required this.failure});
}

class SignInSuccessState extends SignInState {}
