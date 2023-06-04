import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatusBarNotifier extends StateNotifier<bool> {
  StatusBarNotifier() : super(true);

  void setStatusBarHeight() {
    state = !state;
  }
}

final statusBarProvider = StateNotifierProvider<StatusBarNotifier, bool>((ref) {
  return StatusBarNotifier();
});
