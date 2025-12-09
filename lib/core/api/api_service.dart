import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://tuturkata-api-v1.syahranfd.cloud/api",
    headers: {"accept": "application/json"},
  ));

  Future<Response> postLogin(String email, String password) async {
    return await _dio.post(
      "/users/login",
      data: {"email": email, "password": password},
    );
  }
}
