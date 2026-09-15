import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
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

  static const colors = <Color>[
    Color(0xFF2E7D32),
    Color(0xFF006C4C),
    Color(0xFF006A6A),
    Color(0xFF455A64),
    Color(0xFF7A5900),
    Color(0xFF9C1C1C),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Einstellungen')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Darstellung', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          SegmentedButton<ThemeMode>(
            segments: const [
              ButtonSegment(value: ThemeMode.system, label: Text('System'), icon: Icon(Icons.settings_brightness)),
              ButtonSegment(value: ThemeMode.light, label: Text('Hell'), icon: Icon(Icons.light_mode_outlined)),
              ButtonSegment(value: ThemeMode.dark, label: Text('Dunkel'), icon: Icon(Icons.dark_mode_outlined)),
            ],
            selected: {themeMode},
            onSelectionChanged: (value) => onThemeModeChanged(value.first),
          ),
          const SizedBox(height: 28),
          Text('Farbpalette', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: colors.map((color) => InkWell(
              borderRadius: BorderRadius.circular(999),
              onTap: () => onSeedColorChanged(color),
              child: CircleAvatar(
                backgroundColor: color,
                radius: 24,
                child: color == seedColor ? const Icon(Icons.check, color: Colors.white) : null,
              ),
            )).toList(),
          ),
          const SizedBox(height: 32),
          const ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.storage_outlined),
            title: Text('BDS-Datenbank'),
            subtitle: Text('Versionierte lokale Datenbasis. Update-Mechanismus folgt.'),
          ),
        ],
      ),
    );
  }
}
