class Memo {
  final int id;
  final String userId;
  final String articleId;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  Memo({
    required this.id,
    required this.userId,
    required this.articleId,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Memo.fromJson(Map<String, dynamic> json) {
    return Memo(
      id: json['id'],
      userId: json['user_id'],
      articleId: json['article_id'],
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
