import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutur_kata/core/api/api_service.dart';

import 'exercise_level_model.dart';

class ExerciseLevelRepository {
  final ApiService _apiService = ApiService();

  Future<List<ExerciseLevelModel>> getUserExerciseLevel(String levelId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null || token.isEmpty) {
        throw Exception("Token not found");
      }

      final response = await _apiService.getUserExerciseLevel(token, levelId);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = await response.data;
        final exerciseDetail = (data as List)
            .map((json) => ExerciseLevelModel.fromJson(json))
            .toList();
        return exerciseDetail;
      } else {
        throw Exception('Failed to load exercise level');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> postAITranscribe(String filePath) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null || token.isEmpty) {
        throw Exception("Token not found");
      }

      final response = await _apiService.postAITranscribe(token, filePath);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        print("BERHASIL KIRIM FILE .WAV, RETURN:$data");
      } else {
        throw Exception('Failed to transcribe audio');
      }
    } catch (e) {
      rethrow;
    }
  }

}