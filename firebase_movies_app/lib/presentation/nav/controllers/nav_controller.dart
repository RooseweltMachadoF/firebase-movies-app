import 'package:firebase_movies_app/data/models/movie_model.dart';
import 'package:firebase_movies_app/data/repositories/movies_repository/movies_repository.dart';
import 'package:flutter/cupertino.dart';

class NavController extends ChangeNotifier{
  final MoviesRepository moviesRepository;

  NavController(this.moviesRepository);

  int navIndex = 0;

  final List<MovieModel> movieList = [];

  String get getTitle {
    if(navIndex == 0 ) {
      return "Filmes";
    }
    return "Filmes favoritos";
  }

  void selectNavIndex(int index){
    navIndex = index;
    notifyListeners();
  }

  Future<String?> getMovies() async{
    final (String? errorLoadingMovies, List<MovieModel> movies) = await moviesRepository.getMoviesVideo();

    movieList..clear()..addAll(movies);
    return null;
  }
}