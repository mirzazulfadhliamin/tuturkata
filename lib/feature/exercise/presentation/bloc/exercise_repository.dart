import '../../../../core/api/api_service.dart';
import 'exercise_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExerciseRepository {
  final ApiService _apiService = ApiService();

  Future<List<ExerciseModel>> getUserExercises() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        throw Exception("Token not found");
      }

      final response = await _apiService.getUserExercises(token);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = await response.data;
        final exercises = (data as List)
            .map((json) => ExerciseModel.fromJson(json))
            .toList();
        return exercises;
      } else {
        throw Exception('Failed to load exercises');
      }
    } catch (e) {
      rethrow;
    }
  }
}
