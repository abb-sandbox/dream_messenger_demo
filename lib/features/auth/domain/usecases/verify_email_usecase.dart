import 'package:dartz/dartz.dart';
import 'package:dream_messenger_demo/core/failure/failure.dart';
import 'package:dream_messenger_demo/core/usecases/usecase.dart';
import 'package:dream_messenger_demo/features/auth/domain/repositories/auth_repository.dart';

class VerifyEmailUseCase
    extends UseCase<Either<Failure, Unit>, VerifyEmailUseCaseParams> {
  final AuthRepository authRepository;

  VerifyEmailUseCase({required this.authRepository});

  @override
  Future<Either<Failure, Unit>> call(VerifyEmailUseCaseParams params) async {
    return await authRepository.sendLinkToEmail(params.email);
  }
}

class VerifyEmailUseCaseParams {
  final String email;

  VerifyEmailUseCaseParams({required this.email});
}
