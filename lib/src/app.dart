import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/home/home_screen.dart';

class GoodFoodScanApp extends StatefulWidget {
  const GoodFoodScanApp({super.key});

  @override
  State<GoodFoodScanApp> createState() => _GoodFoodScanAppState();
}

class _GoodFoodScanAppState extends State<GoodFoodScanApp> {
  static const _themeKey = 'theme_mode';
  static const _colorKey = 'seed_color';
  ThemeMode _themeMode = ThemeMode.system;
  Color _seedColor = const Color(0xFF2E7D32);

  @override
  void initState() {
    super.initState();
    _restoreSettings();
  }

  Future<void> _restoreSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final themeName = prefs.getString(_themeKey);
    final colorValue = prefs.getInt(_colorKey);
    if (!mounted) return;
    setState(() {
      _themeMode = ThemeMode.values.firstWhere(
        (mode) => mode.name == themeName,
        orElse: () => ThemeMode.system,
      );
      if (colorValue != null) _seedColor = Color(colorValue);
    });
  }

  Future<void> _setThemeMode(ThemeMode value) async {
    setState(() => _themeMode = value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, value.name);
  }

  Future<void> _setSeedColor(Color value) async {
    setState(() => _seedColor = value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_colorKey, value.toARGB32());
  }

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
        onThemeModeChanged: _setThemeMode,
        onSeedColorChanged: _setSeedColor,
      ),
    );
  }

  ThemeData _theme(Brightness brightness) => ThemeData(
        useMaterial3: true,
        brightness: brightness,
        colorScheme: ColorScheme.fromSeed(seedColor: _seedColor, brightness: brightness),
        navigationBarTheme: const NavigationBarThemeData(
          height: 72,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        ),
      );
}
