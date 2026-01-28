import 'package:dream_messenger_demo/core/bloc/themeBloc/theme_event.dart';
import 'package:dream_messenger_demo/features/auth/presentation/widgets/custom_app_bar.dart';
import 'package:dream_messenger_demo/features/auth/presentation/widgets/screen_coverage.dart';
import 'package:dream_messenger_demo/features/auth/presentation/widgets/login_field.dart';
import 'package:dream_messenger_demo/features/auth/presentation/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/themeBloc/theme_bloc.dart';
import '../../../../core/bloc/themeBloc/theme_state.dart';
import '../widgets/google_auth_widget.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final themeBloc = context.read<ThemeBloc>();
    final theme = Theme.of(context);
    return ScreenCoverage(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomAppBar(),
            Expanded(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: size.height * 0.2,
                    // width: size.width * 0.88,
                    margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [LoginField(), PasswordField()],
                    ),
                  ),

                  GoogleAuthWidget(signIn: false),

                  // SizedBox(height: size.height * 0.02),
                  SizedBox(height: size.height * 0.06),

                  InkWell(
                    borderRadius: BorderRadius.circular(size.width * 0.04),
                    onTap: () => Navigator.push,
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(size.width * 0.01),
                      ),
                      child: Padding(
                        padding: EdgeInsetsGeometry.symmetric(
                          vertical: size.height * 0.008,
                          horizontal: size.width * 0.2,
                        ),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: size.width * 0.05,
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
