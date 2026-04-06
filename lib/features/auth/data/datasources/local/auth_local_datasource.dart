import 'package:dartz/dartz.dart';
import 'package:dream_messenger_demo/core/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/failure/failure.dart';

abstract interface class AuthLocalDataSource {
  Future<Either<Failure, Unit>> saveEmail(String email);

  Future<Either<Failure, Unit>> saveSignInCredentials(
    String uid,
    String email,
    String password,
  );

  Future<Either<Failure, Unit>> saveSignUpCredentials(
    String uid,
    String email,
    String password,
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
    String uid,
    String email,
    String password,
  ) async {
    try {
      await _asyncPrefs.setString(Constants.userID, uid);
      await _asyncPrefs.setString(Constants.emailKey, email);
      await _asyncPrefs.setString(Constants.passwordKey, password);
      return Right(unit);
    } catch (err) {
      return Left(LocalDataFailure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveSignUpCredentials(
    String uid,
    String email,
    String password,
  ) async {
    try {
      await _asyncPrefs.setString(Constants.passwordKey, password);
      await _asyncPrefs.setString(Constants.userID, uid);
      await _asyncPrefs.setString(Constants.emailKey, email);

      return Right(unit);
    } catch (err) {
      return Left(LocalDataFailure(message: err.toString()));
    }
  }
}
