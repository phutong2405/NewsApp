class Article {
  final Map<String, dynamic> source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;
  bool isBookmarked;

  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.isBookmarked,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: json['source'] ?? {},
      author: json['author'] ?? "unknown",
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      url: json['url'] ?? "",
      urlToImage: json['urlToImage'] ?? "",
      publishedAt: json['publishedAt'] ?? "",
      content: json['content'] ?? "",
      isBookmarked: false,
    );
  }

  @override
  int get hashCode => url.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Article && runtimeType == other.runtimeType && url == other.url;

  setBookmark() {
    isBookmarked = !isBookmarked;
  }
}
