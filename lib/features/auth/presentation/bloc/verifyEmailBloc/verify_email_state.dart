import '../../../../../core/failure/failure.dart';

abstract class VerifyEmailState {}

class VerifyEmailInitialState extends VerifyEmailState {}

class SendVerifyDataFailure extends VerifyEmailState {
  final Failure failure;

  SendVerifyDataFailure({required this.failure});
}

class SendingVerifyData extends VerifyEmailState {}

class SendVerifyDataSuccess extends VerifyEmailState {}
