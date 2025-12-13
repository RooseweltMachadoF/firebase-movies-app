import 'package:firebase_movies_app/data/models/api_response_model.dart';
import 'package:firebase_movies_app/data/models/movie_model.dart';
import 'package:firebase_movies_app/data/models/video_model.dart';
import 'package:firebase_movies_app/data/repositories/api_repositories/i_api_repositories.dart';
import 'package:firebase_movies_app/data/repositories/movies_repository/movies_video_repository.dart';

class MoviesRepository {
  final IApiRepositories _api;
  final MoviesVideoRepository videoRepository;

  MoviesRepository(this._api, this.videoRepository);

  Future<(String? error, List<MovieModel> video)> getMoviesVideo() async {
    
    final (
      String? getMoviesError,
      ApiResponseModel<Map>? response,
    ) = await _api.get(
      "/3/discover/movie?include_adult=false&language=pt-BR&page=1&sort_by=popularity.desc",
    );

    final moviesToReturn = <MovieModel>[];

    if (response != null) {
      final moviesResults = response.data['results'] as List;

      final List<Future<(String?, VideoModel?)>> moviesFutureList =
          moviesResults
              .map<Future<(String?, VideoModel?)>>(
                (movie) => videoRepository.getMoviesVideo(movie['id'] as int),
              )
              .toList();

      final videosResponse = await Future.wait(moviesFutureList);

      for (var movie in moviesResults) {
        final int videoIndex = videosResponse.indexWhere((v)=> v.$2?.movieId == movie["id"]);

        if(videoIndex != -1){
          movie['videoKey'] = videosResponse[videoIndex].$2?.videoKey;
        }
      }
      final movies = moviesResults.map((movie) => MovieModel.fromMap(movie)).toList();

      moviesToReturn.addAll(movies);
    }
    return (getMoviesError, moviesToReturn);
  }
}
