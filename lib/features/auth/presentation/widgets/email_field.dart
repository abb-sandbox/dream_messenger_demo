import 'package:dream_messenger_demo/core/constants.dart';
import 'package:flutter/material.dart';

class EmailField extends StatefulWidget {
  final TextEditingController emailTextController;

  const EmailField({super.key, required this.emailTextController});

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an email';
        }
        // The Regex for email validation
        final bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
        ).hasMatch(value);

        return emailValid ? null : 'Enter a valid email address';
      },
      controller: widget.emailTextController,
      style: TextStyle(color: theme.colorScheme.surface),
      cursorColor: theme.colorScheme.surface,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: size.height * 0.01,
          horizontal: size.width * 0.01,
        ),
        hintText: "E-mail",
        hintStyle: TextStyle(
          fontStyle: FontStyle.italic,
          color: theme.colorScheme.surface.withValues(alpha: 0.5),
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
