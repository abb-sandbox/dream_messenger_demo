import 'package:dream_messenger_demo/features/auth/domain/entities/sign_in_success_entity.dart';
import 'package:equatable/equatable.dart';

class SignInSuccessModel extends SignInSuccessEntity with EquatableMixin {
  SignInSuccessModel({required super.accessToken, required super.token});

  factory SignInSuccessModel.fromEntity(SignInSuccessEntity e) {
    return SignInSuccessModel(
      accessToken: e.accessToken,
      token: e.token,
    );
  }

  factory SignInSuccessModel.fromJson(Map<String, dynamic> json) {
    return SignInSuccessModel(
      accessToken: json['access_token'],
      token: json['token'],
    );
  }

  @override
  List<Object?> get props => [accessToken, token];
}
