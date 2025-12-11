class ExerciseModel {
  final String exerciseId;
  final int maxLevel;
  final int currentLevel;
  final String title;
  final String desc;

  ExerciseModel({
    required this.exerciseId,
    required this.maxLevel,
    required this.currentLevel,
    required this.title,
    required this.desc,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    if (json['exercise_id'] == null || json['title'] == null) {
      throw ArgumentError('exercise_id and title are required fields');
    }

    return ExerciseModel(
      exerciseId: json['exercise_id'] ?? '',
      maxLevel: json['max_level'] ?? 5,
      currentLevel: json['current_level'] ?? 0,
      title: json['title'] ?? '',
      desc: json['desc'] ?? '',
    );
  }

  int get progressPercentage {
    if (maxLevel == 0) return 0;
    return ((currentLevel / maxLevel) * 100).round();
  }

  bool get isCompleted => currentLevel >= maxLevel;

  Map<String, dynamic> toJson() {
    return {
      'exercise_id': exerciseId,
      'max_level': maxLevel,
      'current_level': currentLevel,
      'title': title,
      'desc': desc,
    };
  }
}
