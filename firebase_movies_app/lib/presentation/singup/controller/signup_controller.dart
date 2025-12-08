import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_movies_app/core/services/firebase/firebase_auth/firebase_auth_service.dart';
import 'package:flutter/cupertino.dart';

class SignupController {
  final signupFormKey = GlobalKey<FormState>();

  Future<(String? error, bool sucess)> onSignUP(String email, String password) async{
    
    if(signupFormKey.currentState!.validate()) {
      final (String? error, UserCredential? user) = await FirebaseAuthService.signUp(email, password);
      
      if(user != null){
        return (null , true);
      }
      return (error , false);
    }
    return (null , false);
  }
}