abstract class Failure {
  String? message;

  Failure({message});
}

class NetworkFailure extends Failure {
  NetworkFailure(message) : super(message: message);
}

class LocalFailure extends Failure {
  LocalFailure(message) : super(message: message);
}
