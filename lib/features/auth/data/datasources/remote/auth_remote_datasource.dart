import 'package:dartz/dartz.dart';
import 'package:dream_messenger_demo/core/failure/failure.dart';

abstract interface class AuthRemoteDataSource {
  Future<Either<Failure, Unit>> sendLinkToEmail(String email);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl();

  @override
  Future<Either<Failure, Unit>> sendLinkToEmail(String email) async {
    try {
      throw UnimplementedError();
    } catch (err) {
      return Left(RemoteDataFailure(message: err.toString()));
    }
  }
}
