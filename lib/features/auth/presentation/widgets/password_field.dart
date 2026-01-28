import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool passwordObscured = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.05,
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        obscureText: passwordObscured,
        style: TextStyle(color: theme.colorScheme.surface),
        cursorColor: theme.colorScheme.surface,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: size.height * 0.01,
            horizontal: size.width * 0.01,
          ),
          suffixIcon: IconButton(
            onPressed: () => setState(() {
              passwordObscured = !passwordObscured;
            }),
            icon: Icon(
              passwordObscured ? Icons.visibility_off : Icons.visibility,
            ),
          ),
          hintText: "Password",
          hintStyle: TextStyle(
            fontStyle: FontStyle.italic,
            color: theme.colorScheme.surface.withOpacity(0.5),
            fontSize: size.width * 0.04,
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
