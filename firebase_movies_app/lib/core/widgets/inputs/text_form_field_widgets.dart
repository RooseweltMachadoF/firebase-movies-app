import 'package:firebase_movies_app/core/config/firebase_movies_app_collors.dart';
import 'package:firebase_movies_app/core/widgets/sized_box/sized_box_widget.dart';
import 'package:firebase_movies_app/core/widgets/texts/text_widget.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidgets extends StatefulWidget {
  final String inputLabel;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final FocusNode focusNode;
  final bool isPassword;
  final TextInputType textInputType;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final ValueNotifier<bool> _isPasswordVN;

  TextFormFieldWidgets({
    required this.inputLabel,
    required this.controller,
    this.validator,
    required this.focusNode,
    this.isPassword = false,
    this.textInputType = TextInputType.text,
    this.textInputAction,
    this.onFieldSubmitted,
    super.key}) : _isPasswordVN = ValueNotifier<bool>(isPassword);
  
  @override
  State<TextFormFieldWidgets> createState() => _TextFormFieldWidgetsState();
}
class _TextFormFieldWidgetsState extends State<TextFormFieldWidgets> {
  bool hasFocus = false;

  @override
  void initState() {
    hasFocus = widget.focusNode.hasFocus;
    widget.focusNode.addListener(_onRequestFocusChange);
    super.initState();
  }

  void _onRequestFocusChange() {
    setState(() {
      hasFocus = widget.focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onRequestFocusChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget.normal(text: widget.inputLabel),
        SizedBoxWidget.xxs(),
        ValueListenableBuilder(
          valueListenable: widget._isPasswordVN,
          builder: (_, bool isPasswordVNValue, _){
            return TextFormField(
              textCapitalization: TextCapitalization.none,
              focusNode: widget.focusNode,
              controller: widget.controller,
              style: TextStyle(
                color: FirebaseMoviesAppCollors.whiteColor,
                fontSize: 16,
              ),
              keyboardType: widget.textInputType,
              autocorrect: false,
              onFieldSubmitted: widget.onFieldSubmitted,
              textInputAction: widget.textInputAction,
              decoration: InputDecoration(
                filled: true,
                errorStyle: TextStyle(
                  color: FirebaseMoviesAppCollors.errorColor,
                  fontSize: 14,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FirebaseMoviesAppCollors.errorColor,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                fillColor: hasFocus ? FirebaseMoviesAppCollors.secundaryColor.withOpacity(.7) : FirebaseMoviesAppCollors.whiteColor.withOpacity(.3),
                suffixIcon: widget.isPassword ? IconButton(
                  onPressed: (){
                    widget._isPasswordVN.value = !isPasswordVNValue;
                  },
                  icon: Icon(isPasswordVNValue ? Icons.visibility_off: Icons.visibility, color: FirebaseMoviesAppCollors.whiteColor,)) : null,
              ),
              obscureText: isPasswordVNValue,
              validator: widget.validator,
            );
          })
      ],
    );
  }
}