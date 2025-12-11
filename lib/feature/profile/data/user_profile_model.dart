class UserProfile {
  final String id;
  final String username;
  final String email;
  final int exp;
  final int streak;
  final String createdAt;
  final String updatedAt;

  UserProfile({
    required this.id,
    required this.username,
    required this.email,
    required this.exp,
    required this.streak,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      exp: json['exp'],
      streak: json['streak'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
