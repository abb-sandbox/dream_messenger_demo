import 'package:dream_messenger_demo/features/auth/domain/entities/sign_in_success_entity.dart';
import 'package:equatable/equatable.dart';

class SignInSuccessModel extends SignInSuccessEntity with EquatableMixin {
  SignInSuccessModel({required super.accessToken, required super.refreshToken});

  factory SignInSuccessModel.fromEntity(SignInSuccessEntity e) {
    return SignInSuccessModel(
      accessToken: e.accessToken,
      refreshToken: e.refreshToken,
    );
  }

  factory SignInSuccessModel.fromJson(Map<String, dynamic> json) {
    return SignInSuccessModel(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }

  @override
  List<Object?> get props => [accessToken, refreshToken];
}
