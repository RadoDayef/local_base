import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.cyan,
    scaffoldBackgroundColor: Color(0xFF0A0E12),
    appBarTheme: AppBarTheme(centerTitle: true, foregroundColor: Colors.cyanAccent, backgroundColor: Colors.transparent, surfaceTintColor: Colors.transparent),
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorSchemeSeed: Colors.cyan,
    scaffoldBackgroundColor: Color(0xFFFFFFFF),
    appBarTheme: AppBarTheme(centerTitle: true, foregroundColor: Colors.cyanAccent, backgroundColor: Colors.transparent, surfaceTintColor: Colors.transparent),
  );
}
