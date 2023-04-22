import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../common/common.dart';

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