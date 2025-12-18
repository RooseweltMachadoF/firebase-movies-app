import 'package:firebase_movies_app/core/widgets/buttons/button_widget.dart';
import 'package:firebase_movies_app/core/widgets/sized_box/sized_box_widget.dart';
import 'package:firebase_movies_app/core/widgets/texts/text_widget.dart';
import 'package:flutter/material.dart';

class ErrorWithButtonWidget extends StatelessWidget {
  final String errorMessage;
  final void Function() tryAgain;

  const ErrorWithButtonWidget({
    super.key,
    required this.errorMessage,
    required this.tryAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextWidget.normal(
          text: errorMessage,
          textAlign: TextAlign.center,),
        SizedBoxWidget.md(),
        ButtonWidget(label: 'Tente novamente', onPressed: tryAgain),
        
      ],
    );
  }
}
