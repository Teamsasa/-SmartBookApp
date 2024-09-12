class User {
  final String id;
  final String name;
  final String email;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> interests;
  final List<String> recentViews;
  final List<String> likes;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.interests,
    required this.recentViews,
    required this.likes,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      interests: List<String>.from(json['interests']),
      recentViews: List<String>.from(json['recent_views']),
      likes: List<String>.from(json['likes']),
    );
  }
}
