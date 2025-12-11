import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/api/api_service.dart';
import '../../data/user_profile_model.dart';

class ProfileRepository {
  final ApiService _api = ApiService();

  Future<UserProfile> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    print("🔑 [DEBUG] Fetching user profile...");
    print("🔑 [DEBUG] Token: $token");

    if (token == null) {
      print("❌ [DEBUG] Token not found!");
      throw Exception("Token not found");
    }

    try {
      final response = await _api.getUserProfile(token);

      print("📥 [DEBUG] Raw API Response:");
      print(response.data);

      final profile = UserProfile.fromJson(response.data);

      print("✅ [DEBUG] Parsed User Profile:");
      print("ID: ${profile.id}");
      print("Username: ${profile.username}");
      print("Email: ${profile.email}");
      print("XP: ${profile.exp}");
      print("Streak: ${profile.streak}");

      return profile;

    } catch (e, stack) {
      print("❌ [DEBUG] Failed to fetch profile!");
      print("Error: $e");
      print("Stacktrace: $stack");

      throw Exception("Failed to fetch profile: $e");
    }
  }

}

