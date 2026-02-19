import 'package:dream_messenger_demo/core/constants.dart';
import 'package:dream_messenger_demo/core/utils/responsive_helper.dart';
import 'package:dream_messenger_demo/shared/widgets/show_snack_bar.dart';
import 'package:dream_messenger_demo/features/auth/presentation/widgets/auth_app_bar.dart';
import 'package:dream_messenger_demo/features/auth/presentation/widgets/screen_coverage.dart';
import 'package:dream_messenger_demo/features/auth/presentation/widgets/email_field.dart';
import 'package:dream_messenger_demo/features/auth/presentation/widgets/password_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/routes/app_routes.dart';
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
                    // color: Colors.green,
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

                        GoogleAuthWidget(signIn: false),

                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: size.height * 0.06,
                          ),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                color: theme.colorScheme.surface,
                                fontSize: context.textSize,
                              ),
                              children: [
                                TextSpan(text: "Already have an account? "),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () =>
                                        Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          AppRoutes.signIn,
                                          (route) => false,
                                        ),
                                  text: "Sign in",
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
                                    Constants.regularRadius,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsGeometry.symmetric(
                                    vertical: context.responsiveValue(8, tablet: 10,desktop: 12),
                                    horizontal: context.responsiveValue(50, tablet: 60, desktop: 70),
                                  ),
                                  child: Text(
                                    "Sign up",
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
