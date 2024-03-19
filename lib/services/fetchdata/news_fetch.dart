import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:newsapplication/models/article.dart';
import 'package:http/http.dart' as http;
import 'package:newsapplication/models/category_item.dart';
import 'package:newsapplication/services/fetchdata/rapid_fetch.dart';

Future<List<Article>> fetchNews(String url) async {
  try {
    final response = await http.get(Uri.parse(url));
    List<dynamic> data = jsonDecode(response.body)['articles'];
    if (response.statusCode == 200) {
      return data.map<Article>((e) => Article.fromJson(e)).toList();
    } else {
      print("Error: ${response.statusCode}");
      return [];
    }
  } catch (e) {
    print("Exception: $e");
    return [];
  }
}

const _apiKey = "ac6527acf98841cc92c111997368da4d";

class FetchingService {
  Future<List<Article>> fetchData(CategoryItem categoryItem) async {
    final url = urlHandler(categoryItem);
    List<Article> data = await fetchNews(url);
    data = dataClean(data);
    return data;
  }

  Future<List<Article>> fetchTopData(CategoryItem categoryItem) async {
    final url = urlHandlerTop(categoryItem);
    List<Article> data = await fetchNews(url);
    data = dataClean(data);
    return data;
  }

  Future<List<Article>> fetchTranslateData(List<Article> data) async {
    List<Article> tmp = data;
    for (var element in tmp) {
      element.title = await getTranslate(element.title) ?? "";
      element.content = await getTranslate(element.content) ?? "";
      element.description = await getTranslate(element.description) ?? "";
      print(element.title);
      print(element.content);
      print(element.description);
    }
    return tmp;
  }

  String urlHandler(CategoryItem categoryItem) {
    late String url;
    if (categoryItem.id == "") {
      url =
          "https://newsapi.org/v2/everything?sources=google-news&apiKey=$_apiKey";
    } else {
      url =
          "https://newsapi.org/v2/everything?pageSize=100&q=${categoryItem.id}&sortBy=popularity&apiKey=$_apiKey";
    }
    return url;
  }

  String urlHandlerTop(CategoryItem categoryItem) {
    late String url;
    if (categoryItem.id == "") {
      url =
          "https://newsapi.org/v2/top-headlines?pageSize=100&country=us&apiKey=$_apiKey";
    } else if (categoryItem.isPage) {
      url =
          "https://newsapi.org/v2/top-headlines?pageSize=100&sources=${categoryItem.id}&apiKey=$_apiKey";
    } else {
      url =
          "https://newsapi.org/v2/top-headlines?pageSize=100&country=us&category=${categoryItem.id}&apiKey=$_apiKey";
    }
    return url;
  }

  List<Article> dataClean(List<Article> data) {
    data.removeWhere(
      (element) =>
          element.urlToImage == "" ||
          element.content == "" ||
          element.title == "",
    );

    for (var element in data) {
      int indexOfT = element.publishedAt.indexOf('T');
      if (indexOfT != -1) {
        element.publishedAt =
            element.publishedAt.replaceRange(indexOfT, indexOfT + 1, ' ');
        final (publishedAt, hour, min) = timeCal(element.publishedAt);
        element.publishedAt = publishedAt;
      }
    }

    return data;
  }
}

(String, int, int) timeCal(String timeInString) {
  DateTime currentDate = DateTime.now();
  String formattedDate = DateFormat("yyyy-MM-dd HH:mmZ").format(currentDate);

  // Hai ngày cần so sánh (chuyển đổi từ chuỗi thành DateTime)
  DateTime date1 = DateTime.parse(formattedDate);
  DateTime date2 = DateTime.parse(timeInString);

  // Tính khoảng cách
  Duration difference = date2.difference(date1);

  // Chuyển đổi khoảng cách sang giờ và phút
  int hours = difference.inHours;
  int minutes = difference.inMinutes.remainder(60);
  hours = hours.abs();
  minutes = minutes.abs();
  if (hours > 0) {
    return ("$hours hours ago", hours, minutes);
  } else if (hours == 1) {
    return ("1 hours ago", 1, minutes);
  }
  return ("$minutes minutes ago", hours, minutes);
}
