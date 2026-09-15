import 'package:flutter/material.dart';

import 'features/home/home_screen.dart';

class GoodFoodScanApp extends StatefulWidget {
  const GoodFoodScanApp({super.key});

  @override
  State<GoodFoodScanApp> createState() => _GoodFoodScanAppState();
}

class _GoodFoodScanAppState extends State<GoodFoodScanApp> {
  ThemeMode _themeMode = ThemeMode.system;
  Color _seedColor = const Color(0xFF2E7D32);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Good Food Scan',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: _theme(Brightness.light),
      darkTheme: _theme(Brightness.dark),
      home: HomeScreen(
        themeMode: _themeMode,
        seedColor: _seedColor,
        onThemeModeChanged: (value) => setState(() => _themeMode = value),
        onSeedColorChanged: (value) => setState(() => _seedColor = value),
      ),
    );
  }

  ThemeData _theme(Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: brightness,
      ),
      navigationBarTheme: const NavigationBarThemeData(
        height: 72,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),
    );
  }
}
