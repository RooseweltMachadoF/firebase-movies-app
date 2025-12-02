import 'package:firebase_movies_app/core/const/errors_const.dart';
import 'package:firebase_movies_app/core/services/dot_env_services.dart';
import 'package:firebase_movies_app/data/models/api_response_model.dart';
import 'package:firebase_movies_app/data/repositories/api_repositories/i_api_repositories.dart';
import 'package:dio/dio.dart';
class DioRepository implements IApiRepositories{
  final Dio _dio;

  DioRepository( this._dio);

  @override
  Future<(String?, ApiResponseModel<T>?)> get<T> (String endpoint) async {
    try {
      final response = await _dio.get(
        endpoint,
        options: Options(
          headers: {"Authorization": "Bearer ${DotEnvServices.getApiToken}"} 
        ));
      return (null, ApiResponseModel<T>(data: response.data as T, statusMessage:response.statusMessage));
    }on DioException catch (dioError) {
      final errorMessage = dioError.message ?? ErrorsConst.API_DEFAULT_ERROR;
      return (errorMessage, null);
    }
  }

}