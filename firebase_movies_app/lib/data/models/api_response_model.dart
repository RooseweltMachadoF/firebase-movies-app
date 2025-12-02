class ApiResponseModel<T> {
  final T data;
  final String? statusMessage;

  ApiResponseModel({required this.data, required this.statusMessage});
}