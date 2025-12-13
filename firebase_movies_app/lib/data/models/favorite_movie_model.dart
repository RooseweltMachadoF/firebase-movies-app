import 'package:firebase_movies_app/data/models/movie_model.dart';

class FavoriteMovieModel extends MovieModel {
  final String favoriteId;

  FavoriteMovieModel({
    required this.favoriteId,
    required super.id,
    required super.title,
    required super.imagePath,
    required super.overView,
    required super.releaseDate,
    required super.voteAverage,
    super.videoId
  });

  factory FavoriteMovieModel.fromMap(Map<String, dynamic> map, String favoriteId) {
    return FavoriteMovieModel(
      id: map['id'] as int ,
      title: map['title'] as String,
      imagePath: map['poster_path'] as String,
      overView: map['overview'] as String, 
      releaseDate: DateTime.parse(map['releaseDate'] as String) , 
      voteAverage: map['vote_average'] as num, 
      videoId: map['videoKey'],
      favoriteId: favoriteId);
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      'id' : id,
      'title' : title,
      'poster_path' : imagePath,
      'overview' : overView,
      //'releaseDate' : '${releaseDate.year}-${releaseDate.month.toString().padLeft(2 , "0")}-${releaseDate.day.toString().padLeft(2, "0")}',
      'releaseDate' : releaseDate.toIso8601String(),
      'vote_average' : voteAverage,
      'videoKey' : videoId,
    };
  }
}
