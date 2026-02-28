import 'package:equatable/equatable.dart';

class SignInSuccessEntity with EquatableMixin {
  final String accessToken;
  final String refreshToken;

  SignInSuccessEntity({required this.accessToken, required this.refreshToken});

  @override
  List<Object?> get props => [accessToken, refreshToken];
}
