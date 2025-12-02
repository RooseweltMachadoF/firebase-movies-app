import 'package:firebase_movies_app/presentation/login/screens/login_screen.dart';
import 'package:firebase_movies_app/presentation/movie_details/screens/movie_details_screen.dart';
import 'package:firebase_movies_app/presentation/nav/screens/nav_screen.dart';
import 'package:firebase_movies_app/presentation/singup/screens/singup_screen.dart';
import 'package:firebase_movies_app/presentation/splash/screens/splash_screen.dart';
import 'package:flutter/widgets.dart';

class FirebaseMoviesAppRoutes {
  static final FirebaseMoviesAppRoutes _singleton = FirebaseMoviesAppRoutes._internal();

  factory FirebaseMoviesAppRoutes() {
    return _singleton;
  }
  
  FirebaseMoviesAppRoutes._internal();

  static Map<String, Widget Function(BuildContext)> getRoutes(){
    return {
      SplashScreen.routeName : (_) {
        return const SplashScreen();
      },

      LoginScreen.routeName: (_) {
        return const LoginScreen();
      },

      SingUpScreen.routeName: (_) {
        return const SingUpScreen();
      },

      NavScreen.routeName: (_) {
        return const NavScreen();
      },
      
      MovieDetailsScreen.routeName: (_) {
        return const MovieDetailsScreen();
      },
    };
  }
}