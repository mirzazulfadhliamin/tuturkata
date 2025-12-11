import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutur_kata/feature/auth/presentation/pages/login_page.dart';
import 'package:tutur_kata/feature/auth/presentation/pages/register_page.dart';
import 'package:tutur_kata/feature/exercise/presentation/pages/exercise_page.dart';
import '../../feature/home/presentation/pages/home_page.dart';
import 'main_shell.dart';

class AppRoute {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }

              final prefs = snapshot.data!;
              final token = prefs.getString('access_token');

              return token != null ? const MainShell() : LoginPage();
            },
          ),
        );

      case "/login":
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
        );
      case "/register":
        return MaterialPageRoute(
          builder: (_) => RegisterPage(),
        );

      case "/home":
        return MaterialPageRoute(
          builder: (_) => const MainShell(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("No Route Found")),
          ),
        );
    }
  }
}
