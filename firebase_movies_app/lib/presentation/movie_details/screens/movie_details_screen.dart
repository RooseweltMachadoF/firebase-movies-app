import 'package:firebase_movies_app/core/services/firebase/firebase_store/firebase_store_service.dart';
import 'package:firebase_movies_app/data/models/favorite_movie_model.dart';
import 'package:firebase_movies_app/presentation/movie_details/factories/movie_detail_controller_factory.dart';
import 'package:firebase_movies_app/presentation/movie_details/widgets/movie_details_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const String routeName = '/movie-details';
  const MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        makeMovieDetailsController(context),
        StreamProvider.value(
          value: FirebaseStoreService().getFavoriteMovies,
          initialData: <FavoriteMovieModel>[],
        ),
      ],
      child: MovieDetailsScreenWidget(),
    );
  }
}
