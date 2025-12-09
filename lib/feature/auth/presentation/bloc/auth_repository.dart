import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/api/api_service.dart';

class AuthRepository {
  final ApiService _apiService = ApiService();

  Future<String> login(String email, String password) async {
    final response = await _apiService.postLogin(email, password);
    final token = response.data["access_token"];

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("access_token", token);

    return token;
  }
}
