import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

Future<void> fetchData() async {
  var uri = Uri.https(
    'ny-times-rss-feed.p.rapidapi.com',
    '/HomePage.xml',
  );

  var headers = {
    'X-RapidAPI-Key': '77c039805cmsh56c610426465918p128207jsn59068905ed1f',
    'X-RapidAPI-Host': 'ny-times-rss-feed.p.rapidapi.com',
  };

  var response = await http.get(uri, headers: headers);

  if (response.statusCode == 200) {
    var xmlString = response.body;
    var jsonString = convertXmlToJson(xmlString);
    print(jsonString);
  } else {
    print('Failed to fetch data. Status code: ${response.statusCode}');
  }
}

String convertXmlToJson(String xmlString) {
  var document = xml.XmlDocument.parse(xmlString);
  var jsonString = jsonEncode(_parseXmlNode(document.rootElement));
  return jsonString;
}

dynamic _parseXmlNode(xml.XmlNode node) {
  if (node is xml.XmlElement) {
    var map = <String, dynamic>{};
    for (var attribute in node.attributes) {
      map[attribute.name.local] = attribute.value;
    }
    for (var child in node.children) {
      var parsedChild = _parseXmlNode(child);
      var childName = child is xml.XmlElement ? child.name.local : null;
      if (childName != null) {
        // Convert repeated elements to lists
        if (map.containsKey(childName)) {
          if (map[childName] is List) {
            map[childName].add(parsedChild);
          } else {
            map[childName] = [map[childName], parsedChild];
          }
        } else {
          map[childName] = parsedChild;
        }
      }
    }
    return map;
  } else if (node is xml.XmlText) {
    // ignore: deprecated_member_use
    return node.text;
  } else {
    return null;
  }
}

// Future<Iterable<DictionaryEntry>> fetchWord(String url) async {
//   try {
//     final response = await http.get(Uri.parse(url));
//     List<dynamic> data = jsonDecode(response.body)['dictionary'];
//     return data.map<DictionaryEntry>((e) => DictionaryEntry.fromJson(e));
//   } catch (e) {
//     return [];
//   }
// }
