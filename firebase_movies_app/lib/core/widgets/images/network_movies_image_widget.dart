import 'package:firebase_movies_app/core/services/dot_env_services.dart';
import 'package:flutter/material.dart';

class NetworkMoviesImageWidget extends StatelessWidget {
  final String movieImage;
  final double? height;
  final BoxFit? boxFit;

  const NetworkMoviesImageWidget({
    super.key,
    required this.movieImage,
    this.height,
    this.boxFit,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      '${DotEnvServices.getApiImagesBaseUrl}$movieImage',
      height: height,
      fit: boxFit,
    );
  }
}
