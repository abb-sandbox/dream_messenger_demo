import 'package:flutter/cupertino.dart';

abstract class SignInEvent {}

class SignInBtnClicked extends SignInEvent {
  final String email;
  final String password;
  final BuildContext context;

  SignInBtnClicked({
    required this.email,
    required this.password,
    required this.context,
  });
}
