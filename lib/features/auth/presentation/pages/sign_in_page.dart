import 'package:dream_messenger_demo/features/auth/presentation/bloc/signInBloc/sign_in_bloc.dart';
import 'package:dream_messenger_demo/features/auth/presentation/pages/sign_up_page.dart';
import 'package:dream_messenger_demo/features/auth/presentation/widgets/auth_app_bar.dart';
import 'package:dream_messenger_demo/features/auth/presentation/widgets/screen_coverage.dart';
import 'package:dream_messenger_demo/features/chat/presentation/pages/chat_list_page.dart';
import 'package:dream_messenger_demo/shared/widgets/show_snack_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../widgets/email_field.dart';
import '../widgets/google_auth_widget.dart';
import '../widgets/password_field.dart';

class SignInPage extends StatefulWidget {
  String? passwordField;
  String? emailField;

  SignInPage({super.key, this.passwordField, this.emailField});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final TextEditingController passwordTextController;
  late final TextEditingController emailTextController;
  late final GlobalKey<FormState> _formKey;
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  @override
  initState() {
    super.initState();
    passwordTextController = TextEditingController(text: widget.passwordField);
    emailTextController = TextEditingController(text: widget.emailField);
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    passwordTextController.dispose();
    emailTextController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
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

                        EmailField(
                          emailTextController: emailTextController,
                          focus: emailFocus,
                          onSubmitted: () {
                            FocusScope.of(context).requestFocus(passwordFocus);
                          },
                        ),

                        SizedBox(height: size.height * 0.02),

                        PasswordField(
                          passwordTextController: passwordTextController,
                          focus: passwordFocus,
                          onSubmitted: _validateAndProceed,
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
                                    ..onTap = () =>Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignUpPage(
                                          emailField:
                                          emailTextController.text,
                                          passwordField:
                                          passwordTextController.text,
                                        ),
                                      ),
                                          (route) => false,
                                    ),
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

                        BlocConsumer<SignInBloc, SignInState>(
                          listener: (context, state) {
                            if (state is SignInSuccessState) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatListPage(
                                    email: emailTextController.text.trim(),
                                  ),
                                ),
                                (route) => false,
                              );
                            } else if (state is SignInFailedState) {
                              showSnackBar(context, state.failure);
                            }
                          },
                          builder: (context, state) {
                            if (state is SignInLoadingState) {
                              return CircularProgressIndicator(
                                color: theme.colorScheme.surface,
                              );
                            }
                            return InkWell(
                              borderRadius: BorderRadius.circular(
                                Constants.regularRadius,
                              ),
                              onTap: () {
                                _validateAndProceed();
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

  _validateAndProceed() {
    final signInBloc = context.read<SignInBloc>();
    if (_formKey.currentState!.validate()) {
      signInBloc.add(
        SignInBtnClicked(
          email: emailTextController.text,
          password: passwordTextController.text,
          context: context,
        ),
      );
    }
  }
}
