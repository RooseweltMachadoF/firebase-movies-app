import 'package:firebase_movies_app/core/services/firebase/firebase_auth/firebase_auth_service.dart';
import 'package:flutter/cupertino.dart';

class LoginController {
  final loginFormKey = GlobalKey<FormState>();

  Future<String?> onLogin(String email, String password) async{

    if(loginFormKey.currentState!.validate()){
      final String? error = await FirebaseAuthService.login(email, password);
      if(error != null){
        return "Email ou senha inválidos";
      }
      return null;
    }
    return "Formulário inválido";
  }
}