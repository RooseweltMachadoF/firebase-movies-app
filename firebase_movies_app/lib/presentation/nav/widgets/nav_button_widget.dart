import 'package:firebase_movies_app/core/config/firebase_movies_app_collors.dart';
import 'package:firebase_movies_app/core/enums/size_enum.dart';
import 'package:firebase_movies_app/core/extensions/ui/sizes_extension.dart';
import 'package:flutter/material.dart';

typedef OnTapNavButton = void Function();

class NavButtonWidget extends StatelessWidget {
  final IconData icon;
  final OnTapNavButton onTap;
  final bool isSelected;
  const NavButtonWidget({
    super.key,
    required this.icon,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected
        ? FirebaseMoviesAppCollors.secundaryColor
        : FirebaseMoviesAppCollors.whiteColor;
    return InkWell(
      onTap: onTap,
      child: IconButton(
        onPressed: onTap,
        icon: Icon(icon, color: color, size: SizesEnum.xl.getSize),
      ),
    );
  }
}
