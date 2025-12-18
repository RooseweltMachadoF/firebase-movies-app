import 'package:firebase_movies_app/core/services/firebase/firebase_store/firebase_store_service.dart';
import 'package:firebase_movies_app/data/models/favorite_movie_model.dart';
import 'package:firebase_movies_app/data/models/movie_model.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class MovieDetailsController {
  final FirebaseStoreService _firebaseStoreService;

  MovieDetailsController(this._firebaseStoreService);

  Future<(String? errorToggleFavoriteMovie, String? sucessToggleFavoriteMovie)>
  toggleFavoriteMovie(
    BuildContext context,
    bool isFavorite,
    MovieModel movie,
  ) async {
    String? responseErrorMessage;
    String? responseSucessMessage;

    if (!isFavorite) {
      List<FavoriteMovieModel> favoriteMovies = [];
      if (context.mounted) {
        favoriteMovies = Provider.of<List<FavoriteMovieModel>>(
          context,
          listen: false,
        );
      }
      final favoriteMoviesIndex = favoriteMovies.indexWhere(
        (element) => element.id == movie.id,
      );

      if (favoriteMoviesIndex != -1) {
        final favoriteMovie = favoriteMovies[favoriteMoviesIndex];

        final (
          String? errorRemovingFavoriteMovieMessage,
          String? sucessRemovingFavoriteMovieMessage,
        ) = await _firebaseStoreService.removeFavoriteMovie(
          favoriteMovie,
        );

        responseSucessMessage = sucessRemovingFavoriteMovieMessage;
        responseErrorMessage = errorRemovingFavoriteMovieMessage;
      } else {
        responseErrorMessage = "Esse filme ainda não foi favoritado";
      }
    } else {
      final String? errorAddingFavoriteMovieMessage =
          await _firebaseStoreService.addFavoriteMovies(movie);

      responseErrorMessage = errorAddingFavoriteMovieMessage;
      if (errorAddingFavoriteMovieMessage == null) {
        responseSucessMessage = "Filme adicionado aos favoritos";
      }
    }
    return (responseErrorMessage, responseSucessMessage);
  }
}
