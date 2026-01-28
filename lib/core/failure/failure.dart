abstract class Failure {
  String message;

  Failure({required this.message});
}

// class FirebaseFailure extends Failure {
//   FirebaseFailure({required super.message});
// }

class LocalDataFailure extends Failure {
  LocalDataFailure({required super.message});
}

class RemoteDataFailure extends Failure {
  RemoteDataFailure({required super.message});
}

class RepositoryLevelFailure extends Failure {
  RepositoryLevelFailure({required super.message});
}

class BlocLevelFailure extends Failure {
  BlocLevelFailure({required super.message});
}
