import 'package:firebase_movies_app/core/factories/api_repository_factory.dart';
import 'package:provider/provider.dart';

class InitialBindings {
  static final InitialBindings _singleton = InitialBindings._internal();

  factory InitialBindings() {
    return _singleton;
  }
  
  InitialBindings._internal();

  static List<Provider> dependecies() {
    return [
      makeApiRepository,
    ];
  }
}