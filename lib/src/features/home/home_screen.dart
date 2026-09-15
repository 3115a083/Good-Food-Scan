import 'package:flutter/material.dart';

import '../scanner/scanner_screen.dart';
import '../settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.themeMode,
    required this.seedColor,
    required this.onThemeModeChanged,
    required this.onSeedColorChanged,
  });

  final ThemeMode themeMode;
  final Color seedColor;
  final ValueChanged<ThemeMode> onThemeModeChanged;
  final ValueChanged<Color> onSeedColorChanged;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const ScannerScreen(),
      const _PlaceholderPage(
        icon: Icons.history_rounded,
        title: 'Verlauf',
        text: 'Deine zuletzt gescannten Produkte erscheinen hier.',
      ),
      const _PlaceholderPage(
        icon: Icons.favorite_outline_rounded,
        title: 'Favoriten',
        text: 'Gespeicherte Produkte erscheinen hier.',
      ),
      SettingsScreen(
        themeMode: widget.themeMode,
        seedColor: widget.seedColor,
        onThemeModeChanged: widget.onThemeModeChanged,
        onSeedColorChanged: widget.onSeedColorChanged,
      ),
    ];

    return Scaffold(
      body: SafeArea(child: IndexedStack(index: _index, children: pages)),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.qr_code_scanner_rounded), label: 'Scannen'),
          NavigationDestination(icon: Icon(Icons.history_rounded), label: 'Verlauf'),
          NavigationDestination(icon: Icon(Icons.favorite_outline_rounded), label: 'Favoriten'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'Einstellungen'),
        ],
      ),
    );
  }
}

class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.icon, required this.title, required this.text});
  final IconData icon;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 16),
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(text, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
