import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_movies_app/core/services/firebase/firebase_auth/firebase_auth_service.dart';
import 'package:firebase_movies_app/data/models/favorite_movie_model.dart';
import 'package:firebase_movies_app/data/models/movie_model.dart';

const FAVORITE_MOVIES_COLLECTION_KEY = "favoriteMovies";

class FirebaseStoreService {
  final moviesAppCollection = FirebaseFirestore.instance.collection('moviesApp');

  Future<String?> addFavoriteMovies (MovieModel movie) async {
    try {
      await moviesAppCollection
      .doc(FirebaseAuthService.getUser!.uid)
      .collection(FAVORITE_MOVIES_COLLECTION_KEY)
      .add(movie.toMap());

      return null;
    }on FirebaseException {
      return "Erro ao adicionar o filme nos favoritos";
    }
  }

  Stream<List<FavoriteMovieModel>> get getFavoriteMovies => 
   moviesAppCollection
      .doc(FirebaseAuthService.getUser!.uid)
      .collection(FAVORITE_MOVIES_COLLECTION_KEY)
      .snapshots()
      .map(_getMoviesListFromSnapshot);

  List<FavoriteMovieModel> _getMoviesListFromSnapshot (QuerySnapshot<Map<String, dynamic>> snapshots) {
    return snapshots.docs.map((favoriteMovie) => FavoriteMovieModel.fromMap(favoriteMovie.data(), favoriteMovie.id)).toList();
  }

  Future<(String? error, String? sucessMessage)> removeFavoriteMovie(FavoriteMovieModel favoriteMovie) async{
    try {
      await moviesAppCollection
                .doc(FirebaseAuthService.getUser!.uid)
                .collection(FAVORITE_MOVIES_COLLECTION_KEY)
                .doc(favoriteMovie.favoriteId)
                .delete();
      return(null, "Filme removido");
    } on FirebaseException {
      return ("Erro ao remover o filme favorito", null);
    }
  }
}