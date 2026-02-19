import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, Unit>> sendLinkToEmail(String email);
}
