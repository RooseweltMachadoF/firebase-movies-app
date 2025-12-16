import 'package:firebase_movies_app/core/const/assets_path_const.dart';
import 'package:firebase_movies_app/core/enums/size_enum.dart';
import 'package:firebase_movies_app/core/extensions/ui/media_query_extension.dart';
import 'package:firebase_movies_app/core/extensions/ui/sizes_extension.dart';
import 'package:firebase_movies_app/core/services/video_player/i_video_player.dart';
import 'package:firebase_movies_app/core/widgets/images/network_movies_image_widget.dart';
import 'package:firebase_movies_app/presentation/nav/controllers/nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class MoviesCarrouselWidget extends StatelessWidget {
  final bool isPortrait;
  final double currentPage;
  final PageController moviesCarrouselCtrl;

  const MoviesCarrouselWidget({
    super.key,
    required this.isPortrait,
    required this.currentPage,
    required this.moviesCarrouselCtrl,
  });

  @override
  Widget build(BuildContext context) {
    final navCtrl = Provider.of<NavController>(context);

    return Stack(
      children: [
        PageView.builder(
          controller: moviesCarrouselCtrl,
          itemCount: navCtrl.movieList.length,
          itemBuilder: (context, index) {
            final selectedMovie = navCtrl.movieList[index];
            final scale = 1 / ((index - currentPage).abs() + 1);
            return Align(
              alignment: Alignment.bottomCenter,
              child: Transform.scale(
                alignment: Alignment.center,
                scale: scale,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: isPortrait ? 0 : 50,
                    bottom: isPortrait ? SizesEnum.md.getSize : 50,
                  ),
                  child: InkWell(
                    onTap: () {
                      Provider.of<IVideoPlayer<YoutubePlayerController>>(
                        context,
                        listen: false,
                      ).pause();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Scaffold(),
                          settings: RouteSettings(arguments: selectedMovie),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(SizesEnum.md.getSize),
                      child: Hero(
                        tag: 'movies-picture-${selectedMovie.id}',
                        child: NetworkMoviesImageWidget(
                          movieImage: selectedMovie.imagePath,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        if (moviesCarrouselCtrl.hasClients &&
            currentPage.round() != moviesCarrouselCtrl.page)
          Positioned(
            left: context.getWidth / 2 - 125,
            bottom: context.getHeight / 2 - 50,
            child: Lottie.asset(AssetsPathConst.animationPopCorn, width: 250),
          ),
      ],
    );
  }
}
