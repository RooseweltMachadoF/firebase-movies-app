import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class FirebaseAuthService {
  static final FirebaseAuthService _singleton = FirebaseAuthService._internal();

  factory FirebaseAuthService() {
    return _singleton;
  }
  
  FirebaseAuthService._internal();

  static User? get getUser => FirebaseAuth.instance.currentUser;

  static Stream<User?> getUserStream (BuildContext context) => FirebaseAuth.instance.authStateChanges();

  static Future<String?>  login (String email, String password) async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (error ) {
      return error.message;
    }
  }

  static Future<(String? error , UserCredential?)> signUp(String email, String password) async{
    try {
      final UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      return (null, user);
    } on FirebaseAuthException catch (error ) {
      return (error.message, null);
    }
  }

  static Future<String?> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return null;
    } on FirebaseAuthException catch (error ) {
      return error.message;
    }
  }
}