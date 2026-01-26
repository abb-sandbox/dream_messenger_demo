import 'package:flutter/material.dart';

abstract class AppTheme {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade300,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Colors.blue.shade500,
      onPrimary: Colors.blue.shade300,
      secondary: Colors.indigoAccent.shade400,
      onSecondary: Colors.indigoAccent.shade200,
      error: Colors.red.shade600,
      onError: Colors.red.shade400,
      surface: Colors.teal.shade500,
      onSurface: Colors.teal.shade300,
    ),
  );

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade800,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Colors.blue.shade800,
      onPrimary: Colors.blue.shade600,
      secondary: Colors.indigoAccent.shade200,
      onSecondary: Colors.indigoAccent,
      error: Colors.red.shade800,
      onError: Colors.red.shade600,
      surface: Colors.teal.shade700,
      onSurface: Colors.teal.shade500,
    ),
  );
}
