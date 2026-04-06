import 'package:dream_messenger_demo/features/auth/presentation/bloc/signInBloc/sign_in_bloc.dart';
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
    final signInBloc = context.read<SignInBloc>();
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
                                if (_formKey.currentState!.validate()) {
                                  signInBloc.add(
                                    SignInBtnClicked(
                                      email: emailTextController.text,
                                      password: passwordTextController.text,
                                      context: context,
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
