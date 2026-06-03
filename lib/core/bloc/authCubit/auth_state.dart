abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthSignedOutState extends AuthState {}

class AuthSignedInState extends AuthState {}

class AuthCubitError extends AuthState {
  final String message;

  AuthCubitError({required this.message});
}
