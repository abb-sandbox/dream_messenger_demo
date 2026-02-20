import 'package:dream_messenger_demo/core/utils/responsive_helper.dart';
import 'package:dream_messenger_demo/features/auth/presentation/widgets/screen_coverage.dart';
import 'package:flutter/material.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenCoverage(
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Text(
              "You are on the chat lists page!",
              style: TextStyle(fontSize: context.textSize),
            ),
          ),
        ),
      ),
    );
  }
}
