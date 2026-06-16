import 'package:dream_messenger_demo/core/bloc/authCubit/auth_cubit.dart';
import 'package:dream_messenger_demo/core/bloc/authCubit/auth_state.dart';
import 'package:dream_messenger_demo/core/bloc/networkCubit/network_cubit.dart';
import 'package:dream_messenger_demo/features/auth/presentation/bloc/signInBloc/sign_in_bloc.dart';
import 'package:dream_messenger_demo/features/auth/presentation/bloc/signUpBloc/sign_up_bloc.dart';
import 'package:dream_messenger_demo/features/auth/presentation/pages/sign_up_page.dart';
import 'package:dream_messenger_demo/features/chat/presentation/pages/chat_list_page.dart';
import 'package:dream_messenger_demo/firebase_options.dart';
import 'package:dream_messenger_demo/shared/widgets/show_snack_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/bloc/themeBloc/theme_bloc.dart';
import 'core/dependencyInjection/service_locator.dart';
import 'features/chat/presentation/bloc/chatCubit/chat_cubit.dart'
    show ChatCubit;
import 'features/chat/presentation/bloc/chatListCubit/chat_list_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initDependencies();
  runApp(const Home());
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<void> _authInitFuture;
  late Future<void> _syncCreds;

  @override
  void initState() {
    super.initState();
    // We initialize the futures here ONCE
    final authCubit = sl<AuthCubit>();
    _authInitFuture = authCubit.init();
    _syncCreds = authCubit.syncLocalCredentials();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NetworkCubit>(create: (_) => sl<NetworkCubit>()),
        BlocProvider<ChatCubit>(create: (_) => sl<ChatCubit>()),
        BlocProvider<AuthCubit>(create: (_) => sl<AuthCubit>()),
        BlocProvider<ThemeBloc>(create: (_) => sl<ThemeBloc>()),
        BlocProvider<SignInBloc>(create: (_) => sl<SignInBloc>()),
        BlocProvider<SignUpBloc>(create: (_) => sl<SignUpBloc>()),
        BlocProvider<ChatListCubit>(create: (_) => sl<ChatListCubit>()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          final authCubit = context.read<AuthCubit>();

          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: state.themeData.brightness == Brightness.dark
                ? SystemUiOverlayStyle.light
                : SystemUiOverlayStyle.dark,
            child: FutureBuilder<void>(
              future: _authInitFuture, // Use the stored variable
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final signedInBefore = authCubit.isLoginInfoSaved;

                  Widget routePage = SignUpPage();

                  if (signedInBefore) {
                    routePage = BlocListener<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthCubitError) {
                          showSnackBar(context, state.failure);
                        }
                      },
                      child: FutureBuilder<void>(
                        future: _syncCreds, // Use the stored variable
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return ChatListPage(email: authCubit.userEmail!);
                          }
                          return const Scaffold(
                            body: Center(
                              child: CircularProgressIndicator(
                                color: Colors.blue,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }

                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    home: routePage,
                    theme: state.themeData,
                    builder: (context, child) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        child: child!,
                      );
                    },
                  );
                }
                return const MaterialApp(
                  home: Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
