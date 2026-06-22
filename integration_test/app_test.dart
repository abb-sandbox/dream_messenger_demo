import 'package:dartz/dartz.dart';
import 'package:dream_messenger_demo/core/bloc/authCubit/auth_cubit.dart';
import 'package:dream_messenger_demo/core/dependencyInjection/service_locator.dart';
import 'package:dream_messenger_demo/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:dream_messenger_demo/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("Sign up, sign in, find another user, send message, sign out ", (
    tester,
  ) async {

    app.main(); // start the app

    await tester.pumpAndSettle();

    await sl<AuthCubit>().signOut(); // sign out before testing to avoid errors

    await tester.pumpAndSettle();

    ///////////////// SIGN UP (START)///////////

    final emailField = find.byKey(const Key("email_input"));
    final passwordField = find.byKey(const Key("password_input"));

    expect(emailField, findsOneWidget);
    expect(passwordField, findsOneWidget);

    await tester.enterText(emailField, "test@dream.app.com");
    await tester.enterText(passwordField, "secret_password");

    await tester.pumpAndSettle();

    expect(find.text("test@dream.app.com"), findsOneWidget);
    expect(find.text("secret_password"), findsOneWidget);

    final signUpBtn = find.byKey(const Key("sign_up_btn"));

    expect(signUpBtn, findsOneWidget);

    await tester.tap(signUpBtn);
    ///////////////// SIGN UP (END)//////////////

    ///////////////// SIGN IN (START) //////////////

    //////////AUTOMATIC WHEN SIGNED UP//////

    ///////////////// SIGN IN (END)//////////////

    /////// FIND ANOTHER USER (START)/////////////

    await tester.pumpAndSettle();

    await Future.delayed(Duration(seconds: 5));

    /////// FIND ANOTHER USER (END)/////////////
  });
}
