import '../../../../../core/failure/failure.dart';

abstract class VerifyEmailState {}

class VerifyEmailInitialState extends VerifyEmailState {}

class SendLinkToEmailFailure extends VerifyEmailState {
  final Failure failure;

  SendLinkToEmailFailure({required this.failure});
}

class SendLinkToEmailSuccess extends VerifyEmailState {}
