import 'package:dream_messenger_demo/features/auth/presentation/pages/sign_up_page.dart';
import 'package:dream_messenger_demo/features/auth/presentation/pages/verify_email_page.dart';
import 'package:flutter/material.dart';

import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.signUp:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case AppRoutes.verifyEmail:
        final args = settings.arguments as String?;
        return MaterialPageRoute(builder: (_) => VerifyEmailPage(email: args!));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
