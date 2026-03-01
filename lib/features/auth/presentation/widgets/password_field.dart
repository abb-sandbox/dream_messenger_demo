import 'package:dream_messenger_demo/core/constants.dart';
import 'package:dream_messenger_demo/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController passwordTextController;

  const PasswordField({super.key, required this.passwordTextController});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool passwordObscured = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty || value.length < 8) {
          return 'Please enter a valid password';
        }
        return null;
      },
      controller: widget.passwordTextController,
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
            passwordObscured ? Icons.visibility_off : Icons.visibility
          ),
          iconSize: context.iconSize,
        ),
        hintText: "Password",
        hintStyle: TextStyle(
          fontStyle: FontStyle.italic,
          color: theme.colorScheme.surface.withValues(alpha: 0.5),
          fontSize: context.textSize,
          // fontSize: size.width * 0.04,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: theme.inputDecorationTheme.border!.borderSide.color,
          ),
          borderRadius: BorderRadius.circular(Constants.regularRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: theme.inputDecorationTheme.border!.borderSide.color,
          ),
          borderRadius: BorderRadius.circular(Constants.regularRadius),
        ),
      ),
    );
  }
}
