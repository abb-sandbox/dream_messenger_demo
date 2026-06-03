import 'package:dream_messenger_demo/core/failure/failure.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthSignedOutState extends AuthState {}

class AuthSignedInState extends AuthState {}

class AuthCubitError extends AuthState {
  final Failure failure;

  AuthCubitError({required this.failure});
}
