import 'package:firebase_movies_app/core/services/video_player/i_video_player.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubePlayerImpl implements IVideoPlayer<YoutubePlayerController>{

  final YoutubePlayerController youtubePlayerController;

  YoutubePlayerImpl({required this.youtubePlayerController});

  @override
  
  get getController => youtubePlayerController;

  @override
  Future<void> load(String videoID, [bool loop = true]) {
    return youtubePlayerController.loadVideoById(videoId: videoID);
  }

  @override
  Future<void> mute() {
    return youtubePlayerController.mute();
  }

  @override
  Future<void> pause() {
    return youtubePlayerController.pauseVideo();
  }

  @override
  Future<void> play() {
    return youtubePlayerController.playVideo();
  }

  @override
  Future<void> unMute() {
    return youtubePlayerController.unMute();
  }
  
}