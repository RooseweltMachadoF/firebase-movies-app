import 'package:firebase_movies_app/core/config/firebase_movies_app_collors.dart';
import 'package:firebase_movies_app/core/config/firebase_movies_app_text_styles.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign? textAlign;
  final Color? color;
  final TextOverflow? overflow;

  const TextWidget({super.key, required this.style , required this.text, this.textAlign, this.color , this.overflow});
  
  TextWidget.bold({
    super.key,
    TextStyle? textStyle ,
    required this.text, 
    this.textAlign, 
    this.color , 
    this.overflow}) : style = textStyle ?? FirebaseMoviesAppTextStyles.getNormalBoldStyle;

    TextWidget.title({
    super.key,
    TextStyle? textStyle ,
    required this.text, 
    this.textAlign, 
    this.color , 
    this.overflow}) : style = textStyle ?? FirebaseMoviesAppTextStyles.getTitleStyle;

    TextWidget.normal({
    super.key,
    TextStyle? textStyle ,
    required this.text, 
    this.textAlign, 
    this.color , 
    this.overflow}) : style = textStyle ?? FirebaseMoviesAppTextStyles.getNormalStyle;

    TextWidget.small({
    super.key,
    TextStyle? textStyle ,
    required this.text, 
    this.textAlign, 
    this.color , 
    this.overflow}) : style = textStyle ?? FirebaseMoviesAppTextStyles.getSmallStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style.copyWith(
        color: color ?? FirebaseMoviesAppCollors.whiteColor
      ),
      textAlign: textAlign,
      overflow: overflow,
    );
  }
}