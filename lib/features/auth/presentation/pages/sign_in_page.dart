import 'package:dream_messenger_demo/features/auth/presentation/widgets/auth_app_bar.dart';
import 'package:dream_messenger_demo/features/auth/presentation/widgets/screen_coverage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../bloc/verifyEmailBloc/verify_email_bloc.dart';
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
                    width: context.responsiveValue(
                      400,
                      tablet: 450,
                      desktop: 500,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: context.responsiveValue(15),
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
                                fontSize: context.textSize,
                              ),
                              children: [
                                TextSpan(text: "Don't have an account? "),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.pop(context),
                                  // Navigator.pushNamedAndRemoveUntil(
                                  //   context,
                                  //   AppRoutes.signUp,
                                  //   (route) => false,
                                  // ),
                                  text: "Sign up",
                                  style: TextStyle(
                                    color: theme.colorScheme.primary,
                                    fontStyle: FontStyle.italic,
                                    fontSize: context.textSize,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        BlocBuilder<VerifyEmailBloc, VerifyEmailState>(
                          builder: (context, state) {
                            if (state is SendingVerifyData) {
                              return CircularProgressIndicator();
                            }
                            return InkWell(
                              borderRadius: BorderRadius.circular(
                                Constants.regularRadius,
                              ),
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.chatList,
                                    arguments: emailTextController.text,
                                  );

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
                                    Constants.regularRadius,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsGeometry.symmetric(
                                    vertical: context.responsiveValue(
                                      8,
                                      tablet: 10,
                                      desktop: 12,
                                    ),
                                    horizontal: context.responsiveValue(
                                      50,
                                      tablet: 60,
                                      desktop: 70,
                                    ),
                                  ),
                                  child: Text(
                                    "Sign in",
                                    style: TextStyle(
                                      fontSize: context.textSize,
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
