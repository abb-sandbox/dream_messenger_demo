import 'package:dream_messenger_demo/core/services/local_data_service.dart';
import 'package:flutter/material.dart';

abstract class ThemeState {
  ThemeData themeData;

  ThemeState({required this.themeData});
}

class ThemeInitialState extends ThemeState {
  ThemeInitialState({required super.themeData});
}

class ThemeSwitchingState extends ThemeState {
  ThemeSwitchingState({required super.themeData});
}

class ThemeSwitchedState extends ThemeState {
  ThemeSwitchedState({required super.themeData});
}

class ThemeSwitchFailureState extends ThemeState {
  ThemeSwitchFailureState({required super.themeData});
}
