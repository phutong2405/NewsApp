import 'dart:convert';

import 'package:newsapplication/models/article.dart';
import 'package:http/http.dart' as http;
import 'package:newsapplication/models/category_item.dart';

Future<List<Article>> fetchNews(String url) async {
  try {
    final response = await http.get(Uri.parse(url));
    List<dynamic> data = jsonDecode(response.body)['articles'];
    if (response.statusCode == 200) {
      return data.map<Article>((e) => Article.fromJson(e)).toList();
    } else {
      // Nếu có lỗi, in ra lỗi
      print("Error: ${response.statusCode}");
      return [];
    }
  } catch (e) {
    // Bắt các lỗi khác nhau
    print("Exception: $e");
    return [];
  }
}

const _apiKey = "ac6527acf98841cc92c111997368da4d";

class FetchingService {
  // String url(String source) {
  //   if (source == "") {
  //     return "https://newsapi.org/v2/top-headlines/sources?apiKey=$_apiKey";
  //   } else {
  //     return "https://newsapi.org/v2/top-headlines?pageSize=100&sources=$source&apiKey=$_apiKey";
  //   }
  // }

  Future<List<Article>> fetchData(CategoryItem categoryItem) async {
    late String url;
    if (categoryItem.name == "") {
      url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=$_apiKey";
    } else if (categoryItem.isPage) {
      url =
          "https://newsapi.org/v2/top-headlines?pageSize=100&sources=${categoryItem.id}&apiKey=$_apiKey";
    } else {
      url =
          "https://newsapi.org/v2/top-headlines?country=us&category=${categoryItem.id}&apiKey=$_apiKey";
    }
    return await fetchNews(url);
  }
}

// Future<Map<String, dynamic>> fetchNews(String apiKey) async {
//   final String apiUrl =
//       "https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey";

//   try {
//     final response = await http.get(Uri.parse(apiUrl));
//     if (response.statusCode == 200) {
//       // Nếu response code là 200, tức là thành công
//       final Map<String, dynamic> data = json.decode(response.body);
//       return data;
//     } else {
//       // Nếu có lỗi, in ra lỗi
//       print("Error: ${response.statusCode}");
//       return null;
//     }
//   } catch (e) {
//     // Bắt các lỗi khác nhau
//     print("Exception: $e");
//     return null;
//   }
// }
