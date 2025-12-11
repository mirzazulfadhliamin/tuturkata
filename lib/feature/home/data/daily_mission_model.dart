class DailyMission {
  final String id;
  final String title;
  final int maxProgress;
  final int currentProgress;
  final bool isCompleted;

  DailyMission({
    required this.id,
    required this.title,
    required this.maxProgress,
    required this.currentProgress,
    required this.isCompleted,
  });

  factory DailyMission.fromJson(Map<String, dynamic> json) {
    return DailyMission(
      id: json["id"],
      title: json["title"],
      maxProgress: json["max_progress"],
      currentProgress: json["current_progress"],
      isCompleted: json["isCompleted"],
    );
  }
}

class NextLevelModel {
  final String exerciseId;
  final String levelId;
  final String title;

  NextLevelModel({
    required this.exerciseId,
    required this.levelId,
    required this.title,
  });

  factory NextLevelModel.fromJson(Map<String, dynamic> json) {
    return NextLevelModel(
      exerciseId: json['exercise_id'] ?? '',
      levelId: json['level_id'] ?? '',
      title: json['title'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exercise_id': exerciseId,
      'level_id': levelId,
      'title': title,
    };
  }
}
