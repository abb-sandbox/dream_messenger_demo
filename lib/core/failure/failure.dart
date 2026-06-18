import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object?> get props => [message];
}

class LocalDataFailure extends Failure {
  const LocalDataFailure({required super.message});
}

class RemoteDataFailure extends Failure {
  const RemoteDataFailure({required super.message});
}

class RepositoryLevelFailure extends Failure {
  const RepositoryLevelFailure({required super.message});
}

class BlocLevelFailure extends Failure {
  const BlocLevelFailure({required super.message});
}

class UseCaseLevelFailure extends Failure {
  const UseCaseLevelFailure({required super.message});
}
