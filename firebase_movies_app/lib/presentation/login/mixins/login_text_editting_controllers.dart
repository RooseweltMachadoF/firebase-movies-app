import 'package:flutter/widgets.dart';

mixin LoginTextEdittingControllers {
  final emailTEC = TextEditingController();
  final passwordTEC = TextEditingController();

  void disposeLoginTECs (){
    emailTEC.dispose();
    passwordTEC.dispose();
  }
}