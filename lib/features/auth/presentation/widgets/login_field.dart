import 'package:flutter/material.dart';

class LoginField extends StatefulWidget {
  const LoginField({super.key});

  @override
  State<LoginField> createState() => _LoginFieldState();
}

class _LoginFieldState extends State<LoginField> {
  final loginTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return SizedBox(
      // height: size.height * (1 / 16),
      child: TextField(
        controller: loginTextController,
        style: TextStyle(color: theme.colorScheme.surface),
        cursorColor: theme.colorScheme.surface,
        decoration: InputDecoration(
          hintText: "E-mail",
          hintStyle: TextStyle(
            fontStyle: FontStyle.italic,
            color: theme.colorScheme.surface.withOpacity(0.8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: theme.inputDecorationTheme.border!.borderSide.color,
            ),
            borderRadius: BorderRadius.circular(size.width * 0.01),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: theme.inputDecorationTheme.border!.borderSide.color,
            ),
            borderRadius: BorderRadius.circular(size.width * 0.01),
          ),
        ),
      ),
    );
  }
}
