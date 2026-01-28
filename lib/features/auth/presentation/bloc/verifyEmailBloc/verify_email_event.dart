abstract class VerifyEmailEvent {}

class SendLinkToEmailEvent extends VerifyEmailEvent {
  final String email;

  SendLinkToEmailEvent({required this.email});
}
