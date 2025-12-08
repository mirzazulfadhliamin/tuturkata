import 'package:flutter/material.dart';
import 'package:tutur_kata/feature/Profile/presentation/pages/profile.dart';
import 'package:tutur_kata/feature/auth/presentation/pages/login_page.dart';
import 'package:tutur_kata/feature/exercise/presentation/pages/exercise_complete.dart';
import 'package:tutur_kata/feature/progress/presentation/pages/progress.dart';
import '../../feature/exercise/presentation/pages/exercise_page.dart';
import '../../feature/home/presentation/pages/home_page.dart';

class AppRoute {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
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
