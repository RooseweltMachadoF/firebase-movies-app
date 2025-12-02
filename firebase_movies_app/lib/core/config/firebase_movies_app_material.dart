import 'package:firebase_movies_app/core/config/firebase_movies_app_collors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FirebaseMoviesAppMaterial {
  static final FirebaseMoviesAppMaterial _singleton = FirebaseMoviesAppMaterial._internal();

  factory FirebaseMoviesAppMaterial() {
    return _singleton;
  }
  
  FirebaseMoviesAppMaterial._internal();

  static const String title= 'Firebase Movies App';

  static const Locale locale = Locale("pt_BR");
  
  static ThemeData get getThemeData => ThemeData(
    scaffoldBackgroundColor: FirebaseMoviesAppCollors.primaryColor,
    primaryColor: FirebaseMoviesAppCollors.primaryColor,
    appBarTheme: AppBarTheme(
      backgroundColor: FirebaseMoviesAppCollors.primaryColor,
      titleTextStyle: TextStyle(
        color: FirebaseMoviesAppCollors.whiteColor,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      centerTitle: true,
      elevation: 0,
    ),
    fontFamily: 'Lato',

  );
}