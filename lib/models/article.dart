class Article {
  final String id;
  final String title;
  final String url;
  final int score;
  final String author;
  final DateTime createdAt;
  final String source;
  final List<String> tags;

  Article({
    required this.id,
    required this.title,
    required this.url,
    required this.score,
    required this.author,
    required this.createdAt,
    required this.source,
    required this.tags,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      score: json['score'],
      author: json['author'],
      createdAt: DateTime.parse(json['created_at']),
      source: json['source'],
      tags: List<String>.from(json['tags']),
    );
  }
}
