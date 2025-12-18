import 'package:firebase_movies_app/core/enums/size_enum.dart';
import 'package:firebase_movies_app/core/extensions/date/date_extension.dart';
import 'package:firebase_movies_app/core/extensions/ui/media_query_extension.dart';
import 'package:firebase_movies_app/core/extensions/ui/sizes_extension.dart';
import 'package:firebase_movies_app/core/mixins/snack_bar_mixin.dart';
import 'package:firebase_movies_app/core/widgets/buttons/favorite_icon_button.dart';
import 'package:firebase_movies_app/core/widgets/images/network_movies_image_widget.dart';
import 'package:firebase_movies_app/core/widgets/others/star_rating/star_rating_widget.dart';
import 'package:firebase_movies_app/core/widgets/sized_box/sized_box_widget.dart';
import 'package:firebase_movies_app/core/widgets/texts/text_widget.dart';
import 'package:firebase_movies_app/data/models/favorite_movie_model.dart';
import 'package:firebase_movies_app/data/models/movie_model.dart';
import 'package:firebase_movies_app/presentation/movie_details/controllers/movie_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieDetailsScreenWidget extends StatefulWidget {
  const MovieDetailsScreenWidget({super.key});

  @override
  State<MovieDetailsScreenWidget> createState() =>
      _MovieDetailsScreenWidgetState();
}

class _MovieDetailsScreenWidgetState extends State<MovieDetailsScreenWidget>
    with SnackBarMixin {
  void toggleFavorites(
    bool isFavorite,
    MovieDetailsController controller,
    MovieModel movie,
  ) async {
    final (errorMessage, sucessMessage) = await controller.toggleFavoriteMovie(
      context,
      isFavorite,
      movie,
    );
    if (context.mounted) {
      showSnackBar(
        context,
        errorMessage ?? sucessMessage!,
        errorMessage != null ? MessageType.error : MessageType.sucess,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)?.settings.arguments as MovieModel;
    final movieDetailsCtrl = Provider.of<MovieDetailsController>(context);
    final favoritesMovies = context.watch<List<FavoriteMovieModel>>();

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                flexibleSpace: Hero(
                  tag: "movie-picture-${movie.id}",
                  child: NetworkMoviesImageWidget(
                    movieImage: movie.imagePath,
                    height: context.getHeight,
                    boxFit: BoxFit.cover,
                  ),
                ),
                collapsedHeight: context.getHeight,
                stretch: true,
              ),
            ],
          ),
          Positioned(
            width: context.getWidth,
            top: context.getHeight / 2.5,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.6),
                    Colors.black.withValues(alpha: 0.9),
                    Colors.black.withValues(alpha: 0.95),
                    Colors.black,
                  ],
                ),
              ),
              height: context.getHeight / 1.5,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(SizesEnum.md.getSize, SizesEnum.md.getSize * 2.5, SizesEnum.md.getSize, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextWidget.title(text: movie.title,textAlign: TextAlign.center,),
                    SizedBoxWidget.xs(),
                    TextWidget.small(text: 'Nos cinemas dia ${movie.releaseDate.convertToDDMMAAAA()}'),
                    SizedBoxWidget.md(),
                    StarRatingWidget(rating: (movie.voteAverage / 2).round(),),
                    SizedBoxWidget.lg(),
                    TextWidget.title(text:"Sinopse",textAlign: TextAlign.center,),
                    SizedBoxWidget.md(),
                    TextWidget.normal(text: movie.overView,textAlign: TextAlign.center,),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: context.getTopPadding + 2,
            right: SizesEnum.md.getSize,
            child: FavoriteIconButton(
              isFavorite: favoritesMovies.indexWhere((fav) => fav.id == movie.id) != -1 ,
              onPressed: (bool isFavorite) {
                toggleFavorites(isFavorite, movieDetailsCtrl, movie); 
              },
            ))
        ],
      ),
    );
  }
}
