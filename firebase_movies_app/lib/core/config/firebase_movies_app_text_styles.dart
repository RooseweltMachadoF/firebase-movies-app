import 'package:firebase_movies_app/core/config/firebase_movies_app_collors.dart';
import 'package:flutter/widgets.dart';

class FirebaseMoviesAppTextStyles {
  static final FirebaseMoviesAppTextStyles _singleton = FirebaseMoviesAppTextStyles._internal();

  factory FirebaseMoviesAppTextStyles() {
    return _singleton;
  }
  
  FirebaseMoviesAppTextStyles._internal();

  static TextStyle get getNormalStyle => TextStyle(
    color: FirebaseMoviesAppCollors.whiteColor,
    fontSize: 14,
  );

  static TextStyle get getNormalBoldStyle => getNormalStyle.copyWith(
    fontWeight: FontWeight.bold,
  );

  static TextStyle get getTitleStyle => getNormalBoldStyle.copyWith(
    fontSize: 24,
  );

  static TextStyle get getSmallStyle => getNormalStyle.copyWith(
    fontSize: 12,
  );

  
}