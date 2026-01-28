import 'package:dream_messenger_demo/features/auth/presentation/widgets/custom_app_bar.dart';
import 'package:dream_messenger_demo/features/auth/presentation/widgets/screen_coverage.dart';
import 'package:dream_messenger_demo/features/auth/presentation/widgets/email_field.dart';
import 'package:dream_messenger_demo/features/auth/presentation/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/themeBloc/theme_bloc.dart';
import '../../../../core/bloc/themeBloc/theme_state.dart';
import '../../../../core/routes/app_routes.dart';
import '../widgets/google_auth_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final themeBloc = context.read<ThemeBloc>();
    final theme = Theme.of(context);
    return ScreenCoverage(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomAppBar(),
            Expanded(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: size.height * 0.25),

                        EmailField(emailTextController: emailTextController),

                        SizedBox(height: size.height * 0.02),

                        PasswordField(
                          passwordTextController: passwordTextController,
                        ),

                        const SizedBox(height: 32),

                        GoogleAuthWidget(signIn: false),

                        // SizedBox(height: size.height * 0.02),
                        SizedBox(height: size.height * 0.06),

                        InkWell(
                          borderRadius: BorderRadius.circular(
                            size.width * 0.04,
                          ),
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.verifyEmail,
                                arguments: emailTextController.text,
                              );
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: BorderRadius.circular(
                                size.width * 0.01,
                              ),
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
