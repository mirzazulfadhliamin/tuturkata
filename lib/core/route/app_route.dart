import 'package:flutter/material.dart';
import '../../feature/home/presentation/pages/home_page.dart';

class AppRoute {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
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
