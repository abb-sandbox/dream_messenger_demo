import 'package:flutter/material.dart';

abstract class SignUpEvent {}

class SignUpBtnClicked extends SignUpEvent {
  final String email;
  final String password;
  final BuildContext context;

  SignUpBtnClicked({
    required this.email,
    required this.password,
    required this.context,
  });
}
