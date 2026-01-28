import 'package:flutter/material.dart';

abstract class AppTheme {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(Colors.black.withOpacity(0.4)),
        iconColor: WidgetStateProperty.all(Colors.black),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Colors.blue.shade500,
      onPrimary: Colors.white,
      secondary: Colors.indigoAccent.shade400,
      onSecondary: Colors.indigoAccent.shade200,
      error: Colors.red.shade600,
      onError: Colors.red.shade400,
      surface: Colors.black,
      onSurface: Colors.white,
    ),
  );

  //-------------------------------------------------------------------------------------------------------------------

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.white),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(Colors.white.withOpacity(0.4)),
        iconColor: WidgetStateProperty.all(Colors.white),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Colors.blue.shade800,
      onPrimary: Colors.grey.shade300,
      secondary: Colors.indigoAccent.shade200,
      onSecondary: Colors.indigoAccent,
      error: Colors.red.shade800,
      onError: Colors.red.shade600,
      surface: Colors.white,
      onSurface: Colors.black,
    ),
  );
}
