import 'package:dartz/dartz.dart';
import 'package:dream_messenger_demo/core/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/failure/failure.dart';

abstract interface class AuthLocalDataSource {
  Future<Either<Failure, Unit>> saveEmail(String email);

  Future<Either<Failure, Unit>> saveSignInCredentials(
    String accessToken,
    int token,
    String email,
  );

  Future<Either<Failure, Unit>> saveSignUpCredentials(
    String accessToken,
    int token,
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
    int token,
    String email,
  ) async {
    try {
      await _asyncPrefs.setString(Constants.firebaseAccessTokenKey, accessToken);
      await _asyncPrefs.setInt(Constants.firebaseTokenKey, token);
      await _asyncPrefs.setString(Constants.emailKey, email);
      return Right(unit);
    } catch (err) {
      return Left(LocalDataFailure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveSignUpCredentials(
    String accessToken,
    int token,
  ) async {
    try {
      await _asyncPrefs.setString(
        Constants.firebaseAccessTokenKey,
        accessToken,
      );
      await _asyncPrefs.setInt(Constants.firebaseTokenKey, token);
      await _asyncPrefs.setString(
        Constants.firebaseAccessTokenKey,
        accessToken,
      );

      return Right(unit);
    } catch (err) {
      return Left(LocalDataFailure(message: err.toString()));
    }
  }
}
