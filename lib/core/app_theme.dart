import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme =>
      ThemeData(appBarTheme: AppBarTheme(centerTitle: true, elevation: 3));

  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(centerTitle: true, elevation: 3),
  );
}
