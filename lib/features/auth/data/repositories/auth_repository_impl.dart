import 'package:dartz/dartz.dart';
import 'package:dream_messenger_demo/core/failure/failure.dart';
import 'package:dream_messenger_demo/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:dream_messenger_demo/features/auth/data/models/auth_user_model.dart';
import 'package:dream_messenger_demo/features/auth/domain/entities/auth_user_entity.dart';
import 'package:dream_messenger_demo/features/auth/domain/entities/sign_in_success_entity.dart';
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
  Future<Either<Failure, Unit>> sendLinkToEmail(AuthUserEntity entity) async {
    try {
      final model = AuthUserModel.fromEntity(entity);
      final remoteResult = await _remoteDatasource.sendLinkToEmail(model);

      return await remoteResult.fold((failure) => Left(failure), (_) async {
        final localResult = await _localDatasource.saveEmail(model.email);
        return localResult.fold((failure) => Left(failure), (_) {
          return const Right(unit);
        });
      });
    } catch (err) {
      return Left(RepositoryLevelFailure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> signIn(
    AuthUserEntity entity,
  ) async {
    try {
      final model = AuthUserModel.fromEntity(entity);
      final remoteResult = await _remoteDatasource.signIn(model);

      return remoteResult.fold((f) => Left(f), (success) async {
        final localResult = await _localDatasource.saveSignInCredentials(
          success.accessToken,
          success.refreshToken,
        );
        return localResult.fold(
          (failure) => Left(failure),
          (_) => Right(unit),
        );
      });
    } catch (err) {
      return Left(RepositoryLevelFailure(message: err.toString()));
    }
  }
}
