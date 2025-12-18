import 'package:firebase_movies_app/core/config/firebase_movies_app_collors.dart';
import 'package:firebase_movies_app/core/enums/size_enum.dart';
import 'package:firebase_movies_app/core/extensions/ui/sizes_extension.dart';
import 'package:flutter/material.dart';

class FavoriteIconButton extends StatelessWidget {
  final Function(bool) onPressed;
  final bool isFavorite;

  const FavoriteIconButton({
    super.key,
    required this.onPressed,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onPressed(!isFavorite),
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_outline,
        size: SizesEnum.xl.getSize,
        color: isFavorite ? FirebaseMoviesAppCollors.favoriteColor : FirebaseMoviesAppCollors.whiteColor,
      ),
    );
  }
}
