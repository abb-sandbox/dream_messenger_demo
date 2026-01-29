import 'package:dream_messenger_demo/features/auth/presentation/widgets/screen_coverage.dart';
import 'package:flutter/material.dart';

class VerifyEmailPage extends StatelessWidget {
  final String email;

  const VerifyEmailPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ScreenCoverage(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back),
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: Text(
                  "Link was sent to $email",
                  style: TextStyle(color: theme.colorScheme.surface),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
