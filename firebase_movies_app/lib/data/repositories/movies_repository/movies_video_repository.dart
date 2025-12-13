import 'package:firebase_movies_app/data/models/api_response_model.dart';
import 'package:firebase_movies_app/data/models/video_model.dart';
import 'package:firebase_movies_app/data/repositories/api_repositories/i_api_repositories.dart';

class MoviesVideoRepository {
  final IApiRepositories _api;

  MoviesVideoRepository(this._api);

  Future<(String? error, VideoModel? video)> getMoviesVideo(int movieId) async {
    final (String? error, ApiResponseModel<Map>? response) = await _api.get(
      "/3/movie/$movieId/videos?language=pt-BR",
    );

    if (response != null) {
      final results = response.data['results'] as List;
      if (results.isNotEmpty) {
        ((results.first) as Map)['movieId'] = movieId;
        final video = VideoModel.fromMap(results.first);
        return (null, video);
      }
      return ("Trailer não disponível", null);
    }

    return (error, null);
  }
}
