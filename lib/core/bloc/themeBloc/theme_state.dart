import 'package:dream_messenger_demo/core/services/local_data_service.dart';
import 'package:flutter/material.dart';

abstract class ThemeState {}

class ThemeInitialState extends ThemeState {
  ThemeData themeData;

  ThemeInitialState({required this.themeData});
}

class ThemeSwitchingState extends ThemeState {}

class ThemeSwitchedState extends ThemeState {
  ThemeData themeData;

  ThemeSwitchedState({required this.themeData});
}

class ThemeSwitchFailureState extends ThemeState {}
