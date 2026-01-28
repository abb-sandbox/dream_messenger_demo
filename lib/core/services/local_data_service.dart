import 'dart:ui';

import 'package:dream_messenger_demo/core/app_global_variables.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../appTheme/app_theme.dart';

class LocalDataService {
  final SharedPreferencesAsync asyncPrefs;

  LocalDataService({required this.asyncPrefs});

  Future<ThemeData> getTheme() async {
    final result = await asyncPrefs.getString(AppGlobalVariables.themeDataKey);
    if (result != null) {
      return result == 'dark' ? AppTheme.darkTheme : AppTheme.lightTheme;
    } else {
      final systemTheme = PlatformDispatcher.instance.platformBrightness;
      return systemTheme == Brightness.dark
          ? AppTheme.darkTheme
          : AppTheme.lightTheme;
    }
  }

  Future<void> setTheme({bool dark = false, bool light = false}) async {
    if (dark || light) {
      await asyncPrefs.setString(
        AppGlobalVariables.themeDataKey,
        light ? 'light' : 'dark',
      );
    }
  }
}
