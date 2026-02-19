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
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return mobileBody;
        } else if (600 <= constraints.maxWidth &&
            constraints.maxWidth <= 1024) {
          return tabletBody;
        } else {
          return desktopBody;
        }
      },
    );
  }
}
