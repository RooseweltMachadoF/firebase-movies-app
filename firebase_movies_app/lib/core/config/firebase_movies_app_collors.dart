import 'dart:ui';

import 'package:flutter/material.dart';

class FirebaseMoviesAppCollors {
  static final FirebaseMoviesAppCollors _firebaseMoviesAppCollors = FirebaseMoviesAppCollors._internal();

  factory FirebaseMoviesAppCollors() {
    return _firebaseMoviesAppCollors;
  }

  FirebaseMoviesAppCollors._internal();

  //Black
  static Color get primaryColor => const Color(0xFF000000);

  //BLUE 
  static Color get secundaryColor => const Color(0xFF2962FF); 

  //RED
  static Color get errorColor => const Color(0xFFDC3545);
  static Color get favoriteColor => Colors.redAccent;

  //White
  static Color get whiteColor => Colors.white;

  //Green
  static Color get sucessColor => Colors.green;
}