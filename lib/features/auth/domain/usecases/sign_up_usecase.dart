import 'package:dartz/dartz.dart';
import 'package:dream_messenger_demo/core/failure/failure.dart';
import 'package:dream_messenger_demo/core/usecases/usecase.dart';
import 'package:dream_messenger_demo/features/auth/domain/entities/auth_user_entity.dart';
import 'package:dream_messenger_demo/features/auth/domain/repositories/auth_repository.dart';

class SignUpUseCase
    extends UseCase<Either<Failure, Unit>, AuthUserEntity> {
  final AuthRepository authRepository;

  SignUpUseCase({required this.authRepository});

  @override
  Future<Either<Failure, Unit>> call(AuthUserEntity params) async {
    return await authRepository.signUp(params);
  }
}
