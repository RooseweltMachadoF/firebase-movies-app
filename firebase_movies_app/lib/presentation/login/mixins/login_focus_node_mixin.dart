import 'package:flutter/material.dart';

mixin LoginFocusNodeMixin {
  final emailFN = FocusNode();
  final passwordFN = FocusNode();

  void disposeFN() {
    emailFN.dispose();
    passwordFN.dispose();
  }
}