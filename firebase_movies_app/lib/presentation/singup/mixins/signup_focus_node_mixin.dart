import 'package:flutter/material.dart';

mixin SignupFocusNodeMixin {
  final emailFN = FocusNode();
  final passwordFN = FocusNode();

  void disposeFN(){
    emailFN.dispose();
    passwordFN.dispose();
  }
}