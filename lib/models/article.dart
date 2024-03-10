// class Article {
//   String id;
//   String url;
//   String author;
//   String date;
//   String type;
//   String title;
//   String content;
//   String thumbnailURL;
//   bool isBookmarked;
//   String contentInVietnamese;

//   Article({
//     required this.id,
//     required this.url,
//     required this.author,
//     required this.date,
//     required this.type,
//     required this.title,
//     required this.content,
//     required this.thumbnailURL,
//     required this.isBookmarked,
//     required this.contentInVietnamese,
//   });

//   factory Article.fromJson(Map<String, dynamic> json) {
//     return Article(
//       id: json['id'] as String,
//       url: json['url'] as String,
//       author: json['author'] as String,
//       date: json['date'] as String,
//       type: json['type'] as String,
//       title: json['title'] as String,
//       content: json['content'] as String,
//       thumbnailURL: json['thumbnailURL'] as String,
//       isBookmarked: json['isBookmarked'] as bool,
//       contentInVietnamese: json['contentInVietnamese'] as String,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'url': url,
//       'author': author,
//       'date': date,
//       'type': type,
//       'title': title,
//       'content': content,
//       'thumbnailURL': thumbnailURL,
//       'isBookmarked': isBookmarked,
//       'contentInVietnamese': contentInVietnamese,
//     };
//   }

//   @override
//   int get hashCode => id.hashCode;

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is Article && runtimeType == other.runtimeType && id == other.id;

//   setBookmark() {
//     isBookmarked = !isBookmarked;
//   }
// }

// List<Article> articleSpawn({required int amount}) {
//   final List<Article> tmp = [];
//   for (var element in List.generate(amount, (index) => index)) {
//     tmp.add(
//       Article(
//         id: "$element",
//         url: "https://example.com/article$element",
//         author: "John Doe",
//         date: "2023-02-13",
//         type: "news",
//         title: "Article $element Title",
//         content: "Article $element content.",
//         thumbnailURL: "https://example.com/article$element.jpg",
//         isBookmarked: false,
//         contentInVietnamese: "Bài viết $element nội dung tiếng Việt.",
//       ),
//     );
//   }
//   return tmp;
// }

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
      source: json['source'] as Map<String, dynamic>,
      author: json['author'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
      urlToImage: json['urlToImage'] as String,
      publishedAt: json['publishedAt'] as String,
      content: json['content'] as String,
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
