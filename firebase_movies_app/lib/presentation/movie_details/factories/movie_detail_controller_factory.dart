import 'package:firebase_movies_app/core/services/firebase/firebase_store/firebase_store_service.dart';
import 'package:firebase_movies_app/presentation/movie_details/controllers/movie_details_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

Provider<MovieDetailsController> makeMovieDetailsController(
  BuildContext context,
) => Provider<MovieDetailsController>(
  create: (_) => MovieDetailsController(FirebaseStoreService()),
);
