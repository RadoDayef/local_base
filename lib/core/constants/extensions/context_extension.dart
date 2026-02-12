import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  Color get homeUserCardColor => isDark ? Color(0xFF1A1F24) : Colors.blue;
}
