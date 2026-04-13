import 'package:dream_messenger_demo/core/bloc/authCubit/auth_cubit.dart';
import 'package:dream_messenger_demo/features/auth/presentation/bloc/signInBloc/sign_in_bloc.dart';
import 'package:dream_messenger_demo/features/auth/presentation/bloc/signUpBloc/sign_up_bloc.dart';
import 'package:dream_messenger_demo/features/auth/presentation/pages/sign_up_page.dart';
import 'package:dream_messenger_demo/features/chat/presentation/pages/chat_list_page.dart';
import 'package:dream_messenger_demo/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/bloc/themeBloc/theme_bloc.dart';
import 'core/dependencyInjection/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initDependencies();
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_) => sl<AuthCubit>()),
        BlocProvider<ThemeBloc>(create: (_) => sl<ThemeBloc>()),
        BlocProvider<SignInBloc>(create: (_) => sl<SignInBloc>()),
        BlocProvider<SignUpBloc>(create: (_) => sl<SignUpBloc>()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          final authCubit = context.read<AuthCubit>();
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: state.themeData.brightness == Brightness.dark
                ? SystemUiOverlayStyle.light
                : SystemUiOverlayStyle.dark,
            child: FutureBuilder<void>(
              future: authCubit.init(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final signedInBefore = authCubit.isLoginInfoSaved;
                  Widget routePage = SignUpPage();
                  if (signedInBefore) {
                    routePage = FutureBuilder<void>(
                      future: authCubit.signInRemotely(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return ChatListPage(email: authCubit.userEmail!);
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        );
                      },
                    );
                  }
                  return MaterialApp(
                    home: routePage,
                    theme: state.themeData,
                    builder: (context, child) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        child: child,
                      );
                    },
                  );
                }
                return Center(child: const CircularProgressIndicator());
              },
            ),
          );
        },
      ),
    );
  }
}
