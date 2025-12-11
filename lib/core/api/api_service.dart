import 'package:dio/dio.dart';

import '../../feature/profile/data/user_profile_model.dart';

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
  
  Future<Response> postRegister(String username, String email, String password) async {
    return await _dio.post(
      "/users/register",
      data: {
        "username": username,
        "email": email,
        "password": password,
      },
    );
  }

  Future<Response> getSummaryWeekly(String token) async {
    return await _dio.get(
      "/progress/summary-weekly",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );
  }

  Future<Response> getUserExercise(String token) async {
    return await _dio.get(
      "/user-exercises/",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );
  }

  Future<Response> getUserExerciseDetail(String token, String exerciseId) async {
    return await _dio.get(
      "/user-levels/$exerciseId",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );
  }
  Future<Response> getUserExerciseLevel(String token, String levelId) async {
    return await _dio.get(
      "/level-quizzes/by-level/$levelId",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );
  }

  Future<Response> getDailyMissions(String token) async{
    return await _dio.get(
      "/daily-missions/",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      ),
    );
  }

  Future<Response> postAITranscribe(String token, String filePath) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          filePath,
          filename: 'audio.m4a',
        ),
      });
      return await _dio.post(
        "/ai/transcribe",
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
  Future<Response> getNextLevel(String token) async {
    return await _dio.get(
      '/user-levels/next',
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      ),
    );
  }
  Future<Response> getUserProfile(String token) async {
    return await _dio.get(
      '/users/me',
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      ),
    );
  }
}

