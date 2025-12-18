import 'package:firebase_movies_app/core/enums/size_enum.dart';
import 'package:firebase_movies_app/core/extensions/ui/media_query_extension.dart';
import 'package:firebase_movies_app/core/extensions/ui/sizes_extension.dart';
import 'package:firebase_movies_app/core/widgets/images/network_movies_image_widget.dart';
import 'package:firebase_movies_app/core/widgets/sized_box/sized_box_widget.dart';
import 'package:firebase_movies_app/core/widgets/texts/text_widget.dart';
import 'package:firebase_movies_app/data/models/favorite_movie_model.dart';
import 'package:firebase_movies_app/presentation/movie_details/screens/movie_details_screen.dart';
import 'package:firebase_movies_app/presentation/nav/controllers/nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesWidget extends StatelessWidget {
  const FavoritesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final navCtrl = context.watch<NavController>();
    final favoriteMovies = Provider.of<List<FavoriteMovieModel>>(context);

    return ColoredBox(
      color: Colors.black,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                SizesEnum.md.getSize,
                SizesEnum.md.getSize,
                SizesEnum.md.getSize,
                0,
              ),
              child: favoriteMovies.isEmpty
                  ? Center(
                      child: TextWidget.normal(
                        text: "Você ainda não possui favoritos",
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
                      itemCount: favoriteMovies.length,
                      itemBuilder: (context, int index) {
                        final favorite = favoriteMovies[index];
                        return Column(
                          children: [
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ChangeNotifierProvider<
                                        NavController
                                      >.value(
                                        value: navCtrl,
                                        child: const MovieDetailsScreen(),
                                      ),
                                  settings: RouteSettings(arguments: favorite),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: context.getWidth * .35,
                                    child: NetworkMoviesImageWidget(
                                      movieImage: favorite.imagePath,
                                    ),
                                  ),
                                  SizedBoxWidget.md(),
                                  Expanded(child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextWidget.normal(text: favorite.title),
                                      SizedBoxWidget.sm(),
                                      TextWidget.small(text: favorite.overView),

                                    ],
                                  )),
                                ],
                              ),
                            ),
                            SizedBoxWidget.md(),
                          ],
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
