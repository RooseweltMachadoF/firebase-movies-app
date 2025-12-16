import 'package:firebase_movies_app/core/extensions/ui/media_query_extension.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';


class MoviesYoutubePlayerWidget extends StatelessWidget {
  final bool isPortrait;
  final YoutubePlayerController youtubePlayerController;

  const MoviesYoutubePlayerWidget({super.key, required this.isPortrait , required this.youtubePlayerController});

  @override
  Widget build(BuildContext context) {
    
    const double youtubeAspectRatio = 16 / 9; 
    
    final double playerWidth = context.getWidth;
    

    return Positioned(
      width: playerWidth,
      top: 10, 
      child: SizedBox(
        height: playerWidth,
        width: playerWidth,
        child: YoutubePlayer(
          controller: youtubePlayerController,
          aspectRatio: youtubeAspectRatio, 
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}
