import 'package:flutter/material.dart';
import 'package:local_base/features/home/ui/home_screen.dart';

class LocalBaseApp extends StatelessWidget {
  const LocalBaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      title: "Local Base",
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.cyan),
      darkTheme: ThemeData(brightness: Brightness.dark, colorSchemeSeed: Colors.cyan, scaffoldBackgroundColor: Color(0xFF0A0E12)),
    );
  }
}
