import 'package:dream_messenger_demo/core/appTheme/app_theme.dart';
import 'package:dream_messenger_demo/core/bloc/themeBloc/theme_event.dart';
import 'package:dream_messenger_demo/core/bloc/themeBloc/theme_state.dart';
import 'package:dream_messenger_demo/core/services/local_data_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  LocalDataService localDataService;
  ThemeData currentTheme;

  ThemeBloc(this.localDataService, this.currentTheme)
    : super(ThemeInitialState(themeData: currentTheme)) {
    on<ThemeSwitchEvent>((event, emit) async {
      emit(ThemeSwitchingState());
      if (currentTheme.brightness == Brightness.light) {
        localDataService.setTheme(true);
        currentTheme = AppTheme.darkTheme;
      } else {
        localDataService.setTheme(false);
        currentTheme = AppTheme.lightTheme;
      }
      emit(ThemeSwitchedState(themeData: currentTheme));
    });
  }
}
