import 'package:equatable/equatable.dart';

class AuthUserEntity with EquatableMixin {
  final String email;
  final String password;

  AuthUserEntity({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
