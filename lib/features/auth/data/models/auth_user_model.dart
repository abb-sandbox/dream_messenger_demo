import 'package:dream_messenger_demo/features/auth/domain/entities/auth_user_entity.dart';
import 'package:equatable/equatable.dart';

class AuthUserModel extends AuthUserEntity with EquatableMixin {
  AuthUserModel({
    required super.email,
    required super.password,
    required super.token,
  });

  Map<String, dynamic> toJson() {
    return {"email": email, "password": password, "token": token};
  }

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      email: json["email"],
      password: json["password"],
      token: json["token"],
    );
  }

  @override
  List<Object?> get props => [email, password, token];
}
