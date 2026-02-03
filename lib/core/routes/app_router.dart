import 'package:dream_messenger_demo/features/auth/presentation/pages/sign_in_page.dart';
import 'package:dream_messenger_demo/features/auth/presentation/pages/sign_up_page.dart';
import 'package:dream_messenger_demo/features/auth/presentation/pages/verify_email_page.dart';
import 'package:flutter/material.dart';

import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.signUp:
        // return _createRoute(const SignUpPage());
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case AppRoutes.signIn:
        return MaterialPageRoute(builder: (_) => const SignInPage());
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

  // static Route _createRoute(Widget page) {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) => page,
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       // This creates a smooth slide-up animation
  //       const begin = Offset(0.0, 1.0);
  //       const end = Offset.zero;
  //       const curve = Curves.ease;
  //
  //       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  //
  //       return SlideTransition(
  //         position: animation.drive(tween),
  //         child: child,
  //       );
  //     },
  //   );
  // }
}
