import 'package:dream_messenger_demo/features/auth/presentation/widgets/custom_app_bar.dart';
import 'package:dream_messenger_demo/features/auth/presentation/widgets/screen_coverage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/services/show_snack_bar.dart';
import '../bloc/verifyEmailBloc/verify_email_bloc.dart';
import '../bloc/verifyEmailBloc/verify_email_state.dart';
import '../widgets/email_field.dart';
import '../widgets/google_auth_widget.dart';
import '../widgets/password_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
    final theme = Theme.of(context);
    return ScreenCoverage(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
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

                        SizedBox(height: size.height * 0.01),

                        GoogleAuthWidget(signIn: true),

                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: size.height * 0.06,
                          ),
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: theme.colorScheme.surface,
                                fontSize: size.width * 0.04,
                              ),
                              children: [
                                TextSpan(text: "Don't have an account? "),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () =>
                                        Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          AppRoutes.signUp,
                                          (route) => false,
                                        ),
                                  text: "Sign up",
                                  style: TextStyle(
                                    color: theme.colorScheme.primary,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        BlocBuilder<VerifyEmailBloc, VerifyEmailState>(
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
                                  // Navigator.pushNamedAndRemoveUntil(
                                  //   context,
                                  //   AppRoutes.chatListPage,
                                  //   (route) => false,
                                  // );

                                  // verifyEmailBloc.add(
                                  //   SendLinkToEmailEvent(
                                  //     email: emailTextController.text,
                                  //   ),
                                  // );
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
                                    "Sign in",
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
