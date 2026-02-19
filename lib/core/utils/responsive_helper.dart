import 'package:dream_messenger_demo/core/constants.dart';
import 'package:flutter/cupertino.dart';

extension ResponsiveHelper on BuildContext {
  bool get isMobile =>
      (MediaQuery.of(this).size.width < Constants.mobileMaxWidth);

  bool get isTablet =>
      Constants.mobileMaxWidth <= MediaQuery.of(this).size.width &&
      MediaQuery.of(this).size.width < Constants.desktopMinWidth;

  bool get isDesktop =>
      MediaQuery.of(this).size.width >= Constants.desktopMinWidth;

  T responsiveValue<T>(T mobile, {T? tablet, T? desktop}) {
    if (isDesktop && (desktop != null)) {
      return desktop;
    } else if (isTablet && (tablet != null)) {
      return tablet;
    }
    return mobile;
  }

  double get iconSize => responsiveValue(25, tablet: 26, desktop: 27);

  double get textSize => responsiveValue(25, tablet: 26, desktop: 27);
}
