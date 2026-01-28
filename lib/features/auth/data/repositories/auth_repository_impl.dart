import 'package:dartz/dartz.dart';
import 'package:dream_messenger_demo/core/failure/failure.dart';
import 'package:dream_messenger_demo/features/auth/data/datasources/remote/remote_datasource.dart';
import 'package:dream_messenger_demo/features/auth/domain/repositories/auth_repository.dart';

import '../datasources/local/local_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteDataSource _remoteDatasource;
  final LocalDataSource _localDatasource;

  AuthRepositoryImpl({
    required RemoteDataSource remoteDatasource,
    required LocalDataSource localDataSource,
  }) : _remoteDatasource = remoteDatasource,
       _localDatasource = localDataSource;

  @override
  Future<Either<Failure, Unit>> sendLinkToEmail(String email) async {
    try {
      final remoteResult = await _remoteDatasource.sendLinkToEmail(email);

      return await remoteResult.fold((failure) => Left(failure), (_) async {
        final localResult = await _localDatasource.saveEmail(email);
        return localResult.fold((failure) => Left(failure), (_) {
          return const Right(unit);
        });
      });
    } catch (err) {
      return Left(RepositoryLevelFailure(message: err.toString()));
    }
  }
}
