import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/common_imports.dart';

final modeProvider = StateNotifierProvider<ModeNotifier, Mode>(
    (ref) => ModeNotifier(Mode.neutral));

class ModeNotifier extends StateNotifier<Mode> {
  ModeNotifier(Mode state) : super(state);

  void changeMode(Mode newMode) {
    if (newMode == state) {
      state = Mode.neutral;
    } else {
      state = newMode;
    }
  }
}
