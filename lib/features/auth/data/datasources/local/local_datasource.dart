import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/failure/failure.dart';

abstract interface class LocalDataSource {
  Future<Either<Failure, Unit>> saveEmail(String email);
}

class LocalDatasourceImpl implements LocalDataSource {
  final SharedPreferencesAsync _asyncPrefs;

  LocalDatasourceImpl({required SharedPreferencesAsync asyncPrefs})
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
