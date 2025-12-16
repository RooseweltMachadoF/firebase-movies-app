import 'package:firebase_movies_app/core/services/video_player/i_video_player.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubePlayerImpl implements IVideoPlayer<YoutubePlayerController> {
  YoutubePlayerController? _controller;

  void _registerListeners() {
    _controller?.listen((state) {
      if (state.hasError) {
        print('>>> DEBUG YOUTUBE: ERRO ENCONTRADO! Código: ${state.error}');
      }

      if (state.playerState == PlayerState.cued) {
        print('>>> DEBUG YOUTUBE: CONTROLLER PRONTO (CUED)');
      }

      if (state.playerState == PlayerState.playing) {
        print('>>> DEBUG YOUTUBE: VÍDEO COMEÇOU!');
      }

      print('>>> DEBUG YOUTUBE: ESTADO ATUAL: ${state.playerState}');
    });
  }

  @override
  Future<void> play() async {
    if (_controller == null) return;
    await _controller!.playVideo();
  }

  @override
  Future<void> pause() async {
    if (_controller == null) return;
    await _controller!.pauseVideo();
  }

  @override
  Future<void> mute() async {
    if (_controller == null) return;
    await _controller!.mute();
  }

  @override
  Future<void> unMute() async {
    if (_controller == null) return;
    await _controller!.unMute();
  }

  void dispose() {
    _controller?.close();
  }

  @override
  Future<void> load(String videoID, [bool loop = true]) async {
    if (_controller == null) {
      _controller = YoutubePlayerController.fromVideoId(
        videoId: videoID,
        autoPlay: true,
        params: const YoutubePlayerParams(
          showFullscreenButton: true,
          showControls: true,
          origin: 'https://www.youtube-nocookie.com',
        ),
      );
      _registerListeners();
    }else{
      await _controller!.loadVideoById(videoId: videoID);
      await _controller!.playVideo();
    }
  }

  @override
  YoutubePlayerController? get getController => _controller;
}
