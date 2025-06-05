import 'package:flutter/material.dart';
import 'package:vibe_vpn/data/local/app_preferences.dart';

class AppThemeData {
  static ThemeData get lightTheme =>
      ThemeData(appBarTheme: AppBarTheme(centerTitle: true, elevation: 3));

  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(centerTitle: true, elevation: 3),
  );
}

extension AppTheme on ThemeData {
  Color get lightTextColor =>
      AppPreferences.isModeDark ? Colors.white70 : Colors.black54;

  Color get bottomNavColor =>
      AppPreferences.isModeDark ? Colors.white12 : Colors.redAccent;
}
