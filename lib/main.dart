import 'package:dream_messenger_demo/core/routes/app_router.dart';
import 'package:dream_messenger_demo/features/auth/presentation/bloc/verifyEmailBloc/verify_email_bloc.dart';
import 'package:dream_messenger_demo/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/bloc/themeBloc/theme_bloc.dart';
import 'core/bloc/themeBloc/theme_state.dart';
import 'core/dependencyInjection/service_locator.dart';
import 'core/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(create: (_) => sl<ThemeBloc>()),
        BlocProvider<VerifyEmailBloc>(create: (_) => sl<VerifyEmailBloc>()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: state.themeData.brightness == Brightness.dark
                ? SystemUiOverlayStyle.light
                : SystemUiOverlayStyle.dark,
            child: MaterialApp(
              initialRoute: AppRoutes.signUp,
              onGenerateRoute: AppRouter.generateRoute,
              builder: (context, child) {
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: child,
                );
              },
              debugShowCheckedModeBanner: false,
              theme: state.themeData,
              // home: SignUpPage(),
            ),
          );
        },
      ),
    );
  }
}
