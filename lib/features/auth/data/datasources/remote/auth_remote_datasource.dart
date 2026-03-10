import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dream_messenger_demo/core/failure/failure.dart';
import 'package:dream_messenger_demo/features/auth/data/models/auth_user_model.dart';
import 'package:dream_messenger_demo/features/auth/data/models/sign_in_success_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/sign_up_success_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<Either<Failure, Unit>> sendLinkToEmail(AuthUserModel model);

  Future<Either<Failure, SignUpSuccessModel>> signUp(AuthUserModel model);

  Future<Either<Failure, SignInSuccessModel>> signIn(AuthUserModel model);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<Either<Failure, Unit>> sendLinkToEmail(AuthUserModel model) async {
    try {
      final response = await dio.post(
        "/api/v1/auth/register",
        data: model.toJson(),
      );
      if (response.statusCode == 201) {
        return Right(unit);
      } else {
        return Left(RemoteDataFailure(message: response.data));
      }
    } catch (err) {
      return Left(RemoteDataFailure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, SignInSuccessModel>> signIn(
    AuthUserModel model,
  ) async {
    try {
      final response = await dio.post(
        "/api/v1/auth/login",
        data: model.toJson(),
      );
      if (response.statusCode == 200) {
        final model = SignInSuccessModel.fromJson(response.data);
        return Right(model);
      } else {
        return Left(
          RemoteDataFailure(message: response.statusMessage.toString()),
        );
      }
    } catch (err) {
      return Left(RemoteDataFailure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, SignUpSuccessModel>> signUp(
    AuthUserModel model,
  ) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: model.email,
            password: model.password,
          );
      return Right(
        SignUpSuccessModel(
          token: credential.credential?.token,
          accessToken: credential.credential?.accessToken,
        ),
      );
    } catch (err) {
      return Left(RemoteDataFailure(message: err.toString()));
    }
  }
}
