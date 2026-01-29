import 'package:dream_messenger_demo/core/services/show_snack_bar.dart';
import 'package:dream_messenger_demo/features/auth/presentation/bloc/verifyEmailBloc/verify_email_event.dart';
import 'package:dream_messenger_demo/features/auth/presentation/bloc/verifyEmailBloc/verify_email_state.dart';
import 'package:dream_messenger_demo/features/auth/presentation/widgets/custom_app_bar.dart';
import 'package:dream_messenger_demo/features/auth/presentation/widgets/screen_coverage.dart';
import 'package:dream_messenger_demo/features/auth/presentation/widgets/email_field.dart';
import 'package:dream_messenger_demo/features/auth/presentation/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/themeBloc/theme_bloc.dart';
import '../../../../core/bloc/themeBloc/theme_state.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/serviceLocator/service_locator.dart';
import '../bloc/verifyEmailBloc/verify_email_bloc.dart';
import '../widgets/google_auth_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final TextEditingController passwordTextController;
  late final TextEditingController emailTextController;
  late final GlobalKey<FormState> _formKey;

  @override
  initState() {
    super.initState();
    passwordTextController = TextEditingController();
    emailTextController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    passwordTextController.dispose();
    emailTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final verifyEmailBloc = context.read<VerifyEmailBloc>();
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

                        BlocConsumer<VerifyEmailBloc, VerifyEmailState>(
                          listener: (context, state) {
                            if (state is SendLinkToEmailFailure) {
                              showSnackBar(context, state.failure);
                            } else if (state is SendLinkToEmailSuccess) {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.verifyEmail,
                                arguments: emailTextController.text,
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is SendingLinkToEmail) {
                              return CircularProgressIndicator();
                            }
                            return InkWell(
                              borderRadius: BorderRadius.circular(
                                size.width * 0.04,
                              ),
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  verifyEmailBloc.add(
                                    SendLinkToEmailEvent(
                                      email: emailTextController.text,
                                    ),
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
                            );
                          },
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
