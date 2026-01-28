import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/failure/failure.dart';

abstract interface class AuthLocalDataSource {
  Future<Either<Failure, Unit>> saveEmail(String email);
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
}
