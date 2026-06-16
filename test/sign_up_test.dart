import 'package:dream_messenger_demo/features/auth/domain/entities/auth_user_entity.dart';
import 'package:dream_messenger_demo/features/auth/domain/repositories/auth_repository.dart';
import 'package:dream_messenger_demo/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

// Import the generated mocks file
import 'sign_up_test.mocks.dart';

// Generate mocks for the repository dependency
@GenerateNiceMocks([MockSpec<AuthRepository>(), MockSpec<AuthUserEntity>()])
void main() {
  late SignUpUseCase usecase;
  late MockAuthUserEntity mockAuthUserEntity;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = SignUpUseCase(authRepository: mockAuthRepository);
    mockAuthUserEntity = MockAuthUserEntity();
  });

  test("should sign up the user successfully through the repository", () async {
    when(
      usecase.call(mockAuthUserEntity),
    ).thenAnswer((_) async => Right("unique_id"));

    expect(usecase.call(mockAuthUserEntity), Right("unique_id"));
  });
}
