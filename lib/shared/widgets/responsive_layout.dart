import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget desktopBody;
  final Widget tabletBody;
  final Widget mobileBody;

  const ResponsiveLayout({
    super.key,
    required this.desktopBody,
    required this.tabletBody,
    required this.mobileBody,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
