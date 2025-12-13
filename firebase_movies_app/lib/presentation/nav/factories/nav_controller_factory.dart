import 'package:firebase_movies_app/data/repositories/api_repositories/i_api_repositories.dart';
import 'package:firebase_movies_app/data/repositories/movies_repository/movies_repository.dart';
import 'package:firebase_movies_app/data/repositories/movies_repository/movies_video_repository.dart';
import 'package:firebase_movies_app/presentation/nav/controllers/nav_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

ChangeNotifierProvider<NavController> makeNavController(BuildContext context) =>
    ChangeNotifierProvider<NavController>(
      create: (_) => NavController(
        MoviesRepository(
          Provider.of<IApiRepositories>(context),
          MoviesVideoRepository(Provider.of<IApiRepositories>(context)),
        ),
      ),
    );
