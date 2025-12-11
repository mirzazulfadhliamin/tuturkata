import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutur_kata/core/api/api_service.dart';

import 'exercise_detail_model.dart';

class ExerciseDetailRepository {
  final ApiService _apiService = ApiService();

  Future<List<ExerciseDetailModel>> getExerciseDetail(String exerciseId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null || token.isEmpty) {
        throw Exception("Token not found");
      }

      final response = await _apiService.getUserExerciseDetail(token, exerciseId);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = await response.data;
        final exerciseDetail = (data as List)
            .map((json) => ExerciseDetailModel.fromJson(json))
            .toList();
        return exerciseDetail;
      } else {
        throw Exception('Failed to load exercise detail');
      }
    } catch (e) {
      rethrow;
    }
  }
}