abstract class SignInEvent {}

class SignInBtnClicked extends SignInEvent {
  final String email;
  final String password;

  SignInBtnClicked({required this.email, required this.password});
}
