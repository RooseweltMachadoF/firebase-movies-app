class VideoModel {
  final int movieId;
  final String videoKey;

  VideoModel({required this.movieId, required this.videoKey});

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      movieId: map['movieId'] as int, 
      videoKey: map['key'] as String, 
      );
  }
}