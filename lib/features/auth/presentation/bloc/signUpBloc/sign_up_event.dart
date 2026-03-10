abstract class SignUpEvent {}

class SignUpBtnClicked extends SignUpEvent {
  final String email;
  final String password;

  SignUpBtnClicked({required this.email, required this.password});
}
