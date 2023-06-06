import "package:flutter/material.dart";

import 'package:notpin/widgets/settings_about.dart';
import 'package:notpin/widgets/settings_main.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          SettingsMain(),
          SettingsAbout(),
        ],
      ),
    );
  }
}
