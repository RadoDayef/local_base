import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:local_base/core/theme/app_theme.dart';
import 'package:local_base/features/home/ui/home_screen.dart';

class LocalBaseApp extends StatelessWidget {
  const LocalBaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      title: "Local Base",
      locale: context.locale,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.system,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
    );
  }
}
