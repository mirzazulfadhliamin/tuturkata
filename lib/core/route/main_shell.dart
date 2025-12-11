import 'package:flutter/material.dart';
import 'package:tutur_kata/core/widgets/bottom_navigation.dart';
import 'package:tutur_kata/feature/home/presentation/pages/home_page.dart';
import 'package:tutur_kata/feature/exercise/presentation/pages/exercise_page.dart';
import 'package:tutur_kata/feature/progress/presentation/pages/progress.dart';
import 'package:tutur_kata/feature/profile/presentation/pages/profile.dart';
import '../theme/color_styles.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  final List<Widget> _pages = const [
    HomePage(),
    ExercisePage(),
    ProgressPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _index,
        onItemSelected: (i) => setState(() => _index = i),
      ),
    );
  }
}