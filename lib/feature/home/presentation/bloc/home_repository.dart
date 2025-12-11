import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/api/api_service.dart';

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
}
