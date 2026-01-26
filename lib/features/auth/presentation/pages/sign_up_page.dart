import 'package:dream_messenger_demo/core/bloc/themeBloc/theme_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/themeBloc/theme_bloc.dart';
import '../../../../core/bloc/themeBloc/theme_state.dart';

class SignUpPage extends StatelessWidget {
  final ThemeState state;

  const SignUpPage({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final themeBloc = context.read<ThemeBloc>();
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.1,
              // color: Colors.green,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.all(16.0),
                    child: IconButton(
                      onPressed: () => themeBloc.add(ThemeSwitchEvent()),
                      icon: Transform.rotate(
                        angle: 0.50,
                        child: Icon(
                          state.themeData.brightness == Brightness.dark
                              ? Icons.brightness_2_outlined
                              : Icons.wb_sunny_outlined,
                          // color: theme.colorScheme.onPrimary,
                          size: size.width * 0.08,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: size.height * 0.3,
                    // width: size.width*0.88,
                    margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
                    color: Colors.amber,
                    child: Center(child: Text("Here would be text fields")),
                  ),
                  SizedBox(height: size.height * 0.06),
                  InkWell(
                    borderRadius: BorderRadius.circular(size.width * 0.04),
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(size.width * 0.04),
                      ),
                      child: Padding(
                        padding: EdgeInsetsGeometry.symmetric(
                          vertical: size.height * 0.01,
                          horizontal: size.width * 0.2,
                        ),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: size.width * 0.06,
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
