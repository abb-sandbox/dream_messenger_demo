import 'package:equatable/equatable.dart';

class AuthUserEntity extends Equatable {
  final String email;
  final String password;

  const AuthUserEntity({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
