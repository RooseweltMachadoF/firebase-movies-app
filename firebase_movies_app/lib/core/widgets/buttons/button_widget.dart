import 'package:firebase_movies_app/core/config/firebase_movies_app_collors.dart';
import 'package:firebase_movies_app/core/widgets/sized_box/sized_box_widget.dart';
import 'package:firebase_movies_app/core/widgets/texts/text_widget.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final bool isBlock;
  final bool isLoading;
  final void Function() onPressed;

  const ButtonWidget({
    required this.label,
    required this.onPressed,
    this.isBlock = false,
    this.isLoading = false,
    super.key});
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: FirebaseMoviesAppCollors.secundaryColor.withOpacity(
            isLoading? .6 : 1
          ),
          fixedSize: isBlock? Size(constraints.maxWidth, 50) : null
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget.normal(text: label),
            if(isLoading)
              ...[
                const SizedBoxWidget.md(),
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(),
                )
              ]
          ],
        ), );
    });
  }
}