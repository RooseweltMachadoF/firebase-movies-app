import 'package:firebase_movies_app/core/mixins/loading_error_mixin.dart';
import 'package:firebase_movies_app/core/services/video_player/i_video_player.dart';
import 'package:firebase_movies_app/core/widgets/others/error_with_button_widget.dart';
import 'package:firebase_movies_app/presentation/nav/controllers/movies_widget_controller.dart';
import 'package:firebase_movies_app/presentation/nav/controllers/nav_controller.dart';
import 'package:firebase_movies_app/presentation/nav/widgets/movies/movies_carrousel_widget.dart';
import 'package:firebase_movies_app/presentation/nav/widgets/movies/movies_cinema_seats_image_widget.dart';
import 'package:firebase_movies_app/presentation/nav/widgets/movies/movies_youtube_player_widget.dart';
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
  void dispose() {
    _moviesCarouselCtrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _moviesCarouselCtrl.addListener(changeVideoPageListener);
      getMoviesAndInitVideo();
    });
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
      initVideo(
        videoId:
            navCtrl.movieList[moviesWidgetCtrl.currentPage.round()].videoId,
      );
    }
  }

  void initVideo({String? videoId}) {
    final navCtrl = Provider.of<NavController>(context, listen: false);

    final firstVideoWithId = navCtrl.movieList.firstWhere(
      (video) => video.videoId != null,
    );
    final videoPlayer = Provider.of<IVideoPlayer<YoutubePlayerController>>(
      context,
      listen: false,
    );

    videoPlayer.load(videoId ?? firstVideoWithId.videoId!);
  }

  Future<void> getMoviesAndInitVideo() async {
    final navCtrl = Provider.of<NavController>(context, listen: false);

    setError(null);
    setIsLoading(true);

    final error = await navCtrl.getMovies();

    setIsLoading(false);
    setError(error);

    if (error == null) {
      initVideo();
    }
  }


  @override
  Widget build(BuildContext context) {
    final navCtrl = context.watch<NavController>();
    final moviesWidgetCtrl = context.watch<MoviesWidgetController>();
    final videoPlayer = context.watch<IVideoPlayer<YoutubePlayerController>>();

    final controller = videoPlayer.getController;

    return OrientationBuilder(
      builder: (_, orientation) {
        final isPortrait = orientation == Orientation.portrait;

        return errorMessage != null
            ? ErrorWithButtonWidget(
                errorMessage: errorMessage!,
                tryAgain: getMoviesAndInitVideo,
              )
            : Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  if (!isLoading && controller != null)
                    MoviesYoutubePlayerWidget(
                      isPortrait: isPortrait,
                      youtubePlayerController: controller,
                    ),

                  if (isPortrait) MoviesCinemaSeatsImageWidget(),

                  if (isLoading)
                    const Center(child: CircularProgressIndicator()),
                  if (!isLoading && navCtrl.movieList.isNotEmpty)
                    MoviesCarrouselWidget(
                      currentPage: moviesWidgetCtrl.currentPage,
                      isPortrait: isPortrait,
                      moviesCarrouselCtrl: _moviesCarouselCtrl,
                    ),
                ],
              );
      },
    );
  }
}
