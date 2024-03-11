import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String?> getTranslate(String content) async {
  var url = Uri.parse(
      'https://google-translate113.p.rapidapi.com/api/v1/translator/text');
  var headers = {
    'content-type': 'application/x-www-form-urlencoded',
    'X-RapidAPI-Key': '77c039805cmsh56c610426465918p128207jsn59068905ed1f',
    'X-RapidAPI-Host': 'google-translate113.p.rapidapi.com',
  };

  var response = await http.post(
    url,
    headers: headers,
    body: {'from': 'auto', 'to': 'vi', 'text': content},
  );

  // Kiểm tra xem yêu cầu có thành công không
  if (response.statusCode == 200) {
    Map<String, dynamic> responseBody = json.decode(response.body);
    return responseBody['trans'];
  } else {
    return "Failed with status code: ${response.statusCode}";
  }
}
