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