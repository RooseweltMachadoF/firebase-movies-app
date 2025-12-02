import 'package:dio/dio.dart';
import 'package:firebase_movies_app/core/services/dot_env_services.dart';
import 'package:firebase_movies_app/data/repositories/api_repositories/dio/dio_repository.dart';
import 'package:firebase_movies_app/data/repositories/api_repositories/i_api_repositories.dart';
import 'package:provider/provider.dart';

final makeApiRepository = Provider<IApiRepositories>(
  create: (_) => DioRepository(
    Dio(
      BaseOptions(
        baseUrl: DotEnvServices.getApiBaseUrl,
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
        ),
    ),
    ));