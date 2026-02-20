import 'package:dartz/dartz.dart';
import 'package:dream_messenger_demo/features/auth/domain/entities/auth_user_entity.dart';

import '../../../../core/failure/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, Unit>> sendLinkToEmail(AuthUserEntity entity);
}
