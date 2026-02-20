abstract class VerifyEmailEvent {}

class SendVerifyDataEvent extends VerifyEmailEvent {
  final String email;
  final String password;

  SendVerifyDataEvent({required this.email, required this.password});
}
