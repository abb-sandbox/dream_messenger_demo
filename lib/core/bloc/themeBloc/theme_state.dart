import 'package:dream_messenger_demo/core/services/local_data_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ThemeState with EquatableMixin {
  final ThemeData themeData;

  ThemeState({required this.themeData});

  @override
  List<Object?> get props => [themeData];
}

class ThemeInitialState extends ThemeState {
  ThemeInitialState({required super.themeData});
}

// class ThemeSwitchingState extends ThemeState {
//   ThemeSwitchingState({required super.themeData});
// }

class ThemeSwitchedState extends ThemeState {
  ThemeSwitchedState({required super.themeData});
}

class ThemeSwitchFailureState extends ThemeState {
  ThemeSwitchFailureState({required super.themeData});
}
