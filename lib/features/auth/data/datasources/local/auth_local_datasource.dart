import 'package:dartz/dartz.dart';
import 'package:dream_messenger_demo/core/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/failure/failure.dart';

abstract interface class AuthLocalDataSource {
  Future<Either<Failure, Unit>> saveEmail(String email);

  Future<Either<Failure, Unit>> saveSignInCredentials(
    String accessToken,
    String refreshToken,
  );
}

class AuthLocalDatasourceImpl implements AuthLocalDataSource {
  final SharedPreferencesAsync _asyncPrefs;

  AuthLocalDatasourceImpl({required SharedPreferencesAsync asyncPrefs})
    : _asyncPrefs = asyncPrefs;

  @override
  Future<Either<Failure, Unit>> saveEmail(String email) async {
    try {
      await _asyncPrefs.setString("temp_email", email);
      return const Right(unit);
    } catch (err) {
      return Left(LocalDataFailure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveSignInCredentials(
    String accessToken,
    String refreshToken,
  ) async {
    try {
      await _asyncPrefs.setString(Constants.accessTokenKey, accessToken);
      await _asyncPrefs.setString(Constants.refreshTokenKey, refreshToken);
      return Right(unit);
    } catch (err) {
      return Left(LocalDataFailure(message: err.toString()));
    }
  }
}
