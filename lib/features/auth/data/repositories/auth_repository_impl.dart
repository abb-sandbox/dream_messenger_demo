import 'package:dartz/dartz.dart';
import 'package:dream_messenger_demo/core/failure/failure.dart';
import 'package:dream_messenger_demo/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:dream_messenger_demo/features/auth/data/models/auth_user_model.dart';
import 'package:dream_messenger_demo/features/auth/domain/entities/auth_user_entity.dart';
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
  Future<Either<Failure, String>> signIn(AuthUserEntity entity) async {
    try {
      final model = AuthUserModel.fromEntity(entity);
      final remoteResult = await _remoteDatasource.signIn(model);

      return remoteResult.fold((f) => Left(f), (success) async {
        final localResult = await _localDatasource.saveSignInCredentials(
          success.uid,
          model.email,
          model.password,
        );
        return localResult.fold(
          (failure) => Left(failure),
          (_) => Right(success.uid),
        );
      });
    } catch (err) {
      return Left(RepositoryLevelFailure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> signUp(AuthUserEntity entity) async {
    try {
      final model = AuthUserModel.fromEntity(entity);
      final signUpRes = await _remoteDatasource.signUp(model);
      return signUpRes.fold((failure) => Left(failure), (success) async {
        final signInRes = await _remoteDatasource.signIn(model);
        return signInRes.fold((failure)=> Left(failure), (_)async{
          final localResult = await _localDatasource.saveSignUpCredentials(
            success.uid,
            model.email,
            model.password,
          );
          return localResult.fold(
                (failure) => Left(failure),
                (_) => Right(success.uid),
          );
        });
      });
    } catch (err) {
      return Left(RepositoryLevelFailure(message: err.toString()));
    }
  }
}
