import 'package:equatable/equatable.dart';

class AuthUserEntity with EquatableMixin {
  final String email;
  final String password;
  final String? token;

  AuthUserEntity({
    required this.email,
    required this.password,
    required this.token,
  });

  @override
  List<Object?> get props => [email, password, token];
}
