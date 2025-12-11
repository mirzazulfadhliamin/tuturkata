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

  Future<String> postAITranscribe(String filePath) async {
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
        // Expect: { text: "Hello" }
        final spokenText = data['text'];
        return spokenText;
      } else {
        print('Transcribe failed: status=${response.statusCode}, data=${response.data}');
        throw Exception('Failed to transcribe audio');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getAIValidate({
    required String instruction,
    required String speechText,
    required String spokenText,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null || token.isEmpty) {
        throw Exception("Token not found");
      }

      final response = await _apiService.getAIValidate(
        token,
        instruction: instruction,
        speechText: speechText,
        spokenText: spokenText,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        // Expect: { message: "complete" } or { message: "feedback text" }
        final message = data['message'];
        return message;
      } else {
        print('Validate failed: status=${response.statusCode}, data=${response.data}');
        throw Exception('Failed to validate speech');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getAITTS({required String message}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null || token.isEmpty) {
        throw Exception("Token not found");
      }

      final response = await _apiService.getAITTS(token, message: message);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        // Expect: { url: "https://...wav" }
        final url = data['url'];
        return url;
      } else {
        print('TTS failed: status=${response.statusCode}, data=${response.data}');
        throw Exception('Failed to get TTS audio URL');
      }
    } catch (e) {
      rethrow;
    }
  }

}