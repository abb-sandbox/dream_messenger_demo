import 'package:equatable/equatable.dart';

class SignInSuccessEntity with EquatableMixin {
  final String accessToken;
  final int token;

  SignInSuccessEntity({required this.accessToken, required this.token});

  @override
  List<Object?> get props => [accessToken, token];
}
