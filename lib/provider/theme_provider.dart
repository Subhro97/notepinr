import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeNotifier extends StateNotifier<bool?> {
  ThemeNotifier() : super(null); // Theme: false/null -> Dark; true -> Light

  void changeTheme(bool value) {
    state = value;
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, bool?>(
  (ref) => ThemeNotifier(),
);
