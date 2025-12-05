import 'package:firebase_movies_app/core/config/firebase_movies_app.dart';
import 'package:firebase_movies_app/core/services/firebase/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await FirebaseService.init();
  await dotenv.load();
  runApp(const FirebaseMoviesApp());
}