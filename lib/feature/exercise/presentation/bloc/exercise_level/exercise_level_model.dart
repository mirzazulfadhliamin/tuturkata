class ExerciseLevelModel {
  final String id;
  final String levelId;
  final int order;
  final String instruction;
  final String speechText;
  final int exp;

  ExerciseLevelModel({
    required this.id,
    required this.levelId,
    required this.order,
    required this.instruction,
    required this.speechText,
    required this.exp,
  });

  factory ExerciseLevelModel.fromJson(Map<String, dynamic> json) {
    return ExerciseLevelModel(
      id: json['id'] ?? '',
      levelId: json['level_id'] ?? '',
      order: json['order'] ?? 0,
      instruction: json['instruction'] ?? '',
      speechText: json['speech_text'] ?? '',
      exp: json['exp'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'level_id': levelId,
      'order': order,
      'instruction': instruction,
      'speech_text': speechText,
      'exp': exp,
    };
  }
}
