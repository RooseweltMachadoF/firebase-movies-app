import 'package:flutter_dotenv/flutter_dotenv.dart';

class DotEnvServices {
  static final DotEnvServices _singleton = DotEnvServices._internal();

  factory DotEnvServices() {
    return _singleton;
  }
  
  DotEnvServices._internal();

  static String get getApiBaseUrl => dotenv.env["API_BASE_URL"] as String;
  static String get getApiImagesBaseUrl => dotenv.env["API_IMG_URL"] as String;
  static String get getApiToken => dotenv.env["API_TOKEN"] as String;
  static String get getVideoApiUrl => dotenv.env["API_VIDEO"] as String;
}