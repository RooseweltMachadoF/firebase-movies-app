import 'package:firebase_movies_app/core/config/firebase_movies_app_collors.dart';
import 'package:firebase_movies_app/core/widgets/texts/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum MessageType {sucess , error}

mixin SnackBarMixin {
  void showSnackBar(BuildContext context, String message, MessageType messageType){
    ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(
      SnackBar(
        content: TextWidget.normal(text: message),
        backgroundColor: 
          messageType == MessageType.error ? FirebaseMoviesAppCollors.errorColor : FirebaseMoviesAppCollors.sucessColor,));
  }
}