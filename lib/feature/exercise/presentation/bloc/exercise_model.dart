// exercise_model.dart
class ExerciseModel {
  final String title;
  final String subtitle;
  final int progress;
  final bool completed;
  final int iconColor;
  final int iconBg;
  final List<int> gradient;

  ExerciseModel({
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.completed,
    required this.iconColor,
    required this.iconBg,
    required this.gradient,
  });
}