import 'package:firebase_movies_app/core/mixins/loading_error_mixin.dart';
import 'package:firebase_movies_app/core/services/video_player/i_video_player.dart';
import 'package:firebase_movies_app/presentation/nav/controllers/movies_widget_controller.dart';
import 'package:firebase_movies_app/presentation/nav/controllers/nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class MoviesWidget extends StatefulWidget {
  const MoviesWidget({super.key});

  @override
  State<MoviesWidget> createState() => _MoviesWidgetState();
}

class _MoviesWidgetState extends State<MoviesWidget> with LoadingErrorMixin {
  final _moviesCarouselCtrl = PageController(viewportFraction: 0.4);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _moviesCarouselCtrl.addListener(changeVideoPageListener);
    });
    super.initState();
  }

  void changeVideoPageListener() {
    final navCtrl = Provider.of<NavController>(context, listen: false);
    final moviesWidgetCtrl = Provider.of<MoviesWidgetController>(
      context,
      listen: false,
    );

    setState(() {
      moviesWidgetCtrl.currentPage = _moviesCarouselCtrl.page ?? 0;
    });

    if (moviesWidgetCtrl.currentPage.round() == moviesWidgetCtrl.currentPage) {
      initVideo(videoId : navCtrl.movieList[moviesWidgetCtrl.currentPage.round()].videoId);
    }
  }

  void initVideo({String? videoId}) async {
    final navCtrl = Provider.of<NavController>(context, listen: false);
    final videoPlayerCtrl = Provider.of<IVideoPlayer<YoutubePlayerController>>(
      context,
      listen: false,
    );
    final firstVideoWithId = navCtrl.movieList.firstWhere((video) => video.videoId != null);
    videoPlayerCtrl.load(videoId ?? firstVideoWithId.videoId! );
  }

  Future<void> getMoviesAndInitVideo() async{
    final navCtrl = Provider.of<NavController>(context, listen: false);

    setError(null);
    setIsLoading(true);

    final error = await navCtrl.getMovies();

    setIsLoading(false);
    setError(error);

    if(error == null){
      initVideo();
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
