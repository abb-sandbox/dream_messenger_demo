import 'package:dartz/dartz.dart';
import 'package:dream_messenger_demo/features/auth/data/models/auth_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/failure/failure.dart';

abstract interface class AuthRemoteDataSource {
  Future<Either<Failure, Unit>> sendLinkToEmail(String email);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  AuthRemoteDataSourceImpl({required FirebaseAuth firebaseAuth})
    : _firebaseAuth = firebaseAuth;

  @override
  Future<Either<Failure, Unit>> sendLinkToEmail(String email) async {
    try {
      final actionCodeSettings = ActionCodeSettings(
        url: "https://dream-demo-5afa7.firebaseapp.com",
        androidInstallApp: true,
        androidPackageName: "com.example.dream_messenger_demo",
        handleCodeInApp: true,
      );
      await _firebaseAuth.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: actionCodeSettings,
      );
      return const Right(unit);
    } catch (err) {
      return Left(RemoteDataFailure(message: err.toString()));
    }
  }
}
