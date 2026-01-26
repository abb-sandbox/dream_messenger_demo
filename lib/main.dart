import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/bloc/themeBloc/theme_bloc.dart';
import 'core/bloc/themeBloc/theme_state.dart';
import 'core/serviceLocator/service_locator.dart';

void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ThemeBloc>(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            theme: state.themeData,
            home: Scaffold(
              appBar: AppBar(
                title: Text("Registration page"),
                centerTitle: true,
              ),
            ),
          );
        },
      ),
    );
  }
}
