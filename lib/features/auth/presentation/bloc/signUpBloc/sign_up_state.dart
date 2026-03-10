import 'package:dream_messenger_demo/core/failure/failure.dart' show Failure;

abstract class SignUpState {}

class SignUpInitialState extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpSuccessState extends SignUpState {}

class SignUpFailureState extends SignUpState {
  final Failure failure;

  SignUpFailureState({required this.failure});
}
