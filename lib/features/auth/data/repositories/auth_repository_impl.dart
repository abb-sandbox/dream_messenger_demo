import 'package:dartz/dartz.dart';
import 'package:dream_messenger_demo/core/failure/failure.dart';
import 'package:dream_messenger_demo/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:dream_messenger_demo/features/auth/domain/repositories/auth_repository.dart';

import '../datasources/local/auth_local_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDatasource;
  final AuthLocalDataSource _localDatasource;

  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDatasource,
    required AuthLocalDataSource localDataSource,
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
