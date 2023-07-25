import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardModeNotifier extends StateNotifier<String?> {
  CardModeNotifier() : super(null);

  void setCardMode(String? mode) {
    state = mode;
  }
}

final cardModeProvider = StateNotifierProvider<CardModeNotifier, String?>(
    (ref) => CardModeNotifier());
