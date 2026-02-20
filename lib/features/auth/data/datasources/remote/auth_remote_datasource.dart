import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dream_messenger_demo/core/failure/failure.dart';
import 'package:dream_messenger_demo/features/auth/data/models/auth_user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<Either<Failure, Unit>> sendLinkToEmail(AuthUserModel model);
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
}
