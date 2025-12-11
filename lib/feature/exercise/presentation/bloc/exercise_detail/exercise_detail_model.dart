class ExerciseDetailModel {
  final String levelId;
  final int order;
  final String title;
  final String desc;
  final int star;
  final int accuration;
  final DateTime? updatedAt;
  final bool isCompleted;

  ExerciseDetailModel({
    required this.levelId,
    required this.order,
    required this.title,
    required this.desc,
    required this.star,
    required this.accuration,
    this.updatedAt,
    required this.isCompleted,
  });

  factory ExerciseDetailModel.fromJson(Map<String, dynamic> json) {
    return ExerciseDetailModel(
      levelId: json['level_id'] ?? '',
      order: json['order'] ?? 0,
      title: json['title'] ?? '',
      desc: json['desc'] ?? '',
      star: json['star'] ?? 0,
      accuration: json['accuration'] ?? 0,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  int get progressPercentage {
    if (order == 0) return 0;
    return ((accuration / order) * 100).round();
  }

  bool get isExerciseCompleted => star > 0 && accuration > 0 && isCompleted;

  Map<String, dynamic> toJson() {
    return {
      'level_id': levelId,
      'order': order,
      'title': title,
      'desc': desc,
      'star': star,
      'accuration': accuration,
      'updated_at': updatedAt?.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }
}
