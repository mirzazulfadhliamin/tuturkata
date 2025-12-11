import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/api/api_service.dart';
import '../../data/daily_mission_model.dart';

class HomeRepository {
  final ApiService _api = ApiService();

  Future<Map<String, dynamic>> getWeeklySummary() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");

    if (token == null) {
      throw Exception("Token tidak ditemukan, silakan login ulang");
    }

    final response = await _api.getSummaryWeekly(token);
    return response.data;
  }
  Future<List<DailyMission>> getDailyMissions() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");

    if (token == null) throw Exception("Token tidak ditemukan");

    final response = await _api.getDailyMissions(token);

    List data = response.data;

    return data.map((e) => DailyMission.fromJson(e)).toList();
  }

  Future<NextLevelModel> getNextLevel() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      throw Exception("Token not found");
    }

    try {
      final response = await _api.getNextLevel(token);

      return NextLevelModel.fromJson(response.data);

    } catch (e) {
      throw Exception("Failed to fetch next level: $e");
    }
  }

}
