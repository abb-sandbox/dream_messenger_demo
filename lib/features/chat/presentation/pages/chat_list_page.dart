import 'package:dream_messenger_demo/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class ChatListPage extends StatelessWidget {
  final String email;

  const ChatListPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: theme.scaffoldBackgroundColor),
        body: Center(
          child: Text(
            "You are on the chat lists page $email!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.textSize,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
        ),
      ),
    );
  }
}
