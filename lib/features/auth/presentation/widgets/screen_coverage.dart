import 'package:flutter/material.dart';

class ScreenCoverage extends StatelessWidget {
  final Widget child;

  const ScreenCoverage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.scaffoldBackgroundColor.withOpacity(0.8),
      child: SafeArea(child: child),
    );
  }
}
