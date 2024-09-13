class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String>? interests;
  final List<String>? recentViews;
  final List<String>? likes;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
    this.interests,
    this.recentViews,
    this.likes,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      interests: json['interests'] != null
          ? List<String>.from(json['interests'])
          : null,
      recentViews: json['recent_views'] != null
          ? List<String>.from(json['recent_views'])
          : null,
      likes: json['likes'] != null ? List<String>.from(json['likes']) : null,
    );
  }
}
