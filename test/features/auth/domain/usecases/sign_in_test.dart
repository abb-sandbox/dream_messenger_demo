import 'package:dream_messenger_demo/core/failure/failure.dart';
import 'package:dream_messenger_demo/features/auth/domain/entities/auth_user_entity.dart';
import 'package:dream_messenger_demo/features/auth/domain/repositories/auth_repository.dart';
import 'package:dream_messenger_demo/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'sign_in_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AuthRepository>()])
void main() {
  late SignInUseCase usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = SignInUseCase(authRepository: mockAuthRepository);
  });

  group("SignInUseCase", () {
    const tAuthUserEntity = AuthUserEntity(
      email: "test@example.com",
      password: "password123",
    );

    test(
      "should return Right(UID) when repository.signIn is successful",
      () async {
        // arrange
        when(
          mockAuthRepository.signUp(any),
        ).thenAnswer((_) async => const Right("unique_id"));

        // act
        final result = await usecase.call(tAuthUserEntity);

        // assert
        expect(result, const Right<Failure, String>("unique_id"));

        // Perfect verification: check for specific data, not just 'any'
        verify(mockAuthRepository.signUp(tAuthUserEntity)).called(1);
        verifyNoMoreInteractions(mockAuthRepository);
      },
    );

    test("should return Left(Failure) when repository.signIn fails", () async {
      // arrange
      const tFailure = RepositoryLevelFailure(message: "Error occurred");
      when(
        mockAuthRepository.signUp(any),
      ).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await usecase.call(tAuthUserEntity);

      // assert
      expect(result, const Left<Failure, String>(tFailure));

      verify(mockAuthRepository.signUp(tAuthUserEntity)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });
  });
}
