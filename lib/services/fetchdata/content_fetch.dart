// import 'package:http/http.dart' as;

// Future<void> fullContent() async {
//   // Build the URL we are going to request. This will get articles related to Apple and sort them newest first
//   String url =
//       'https://newsapi.org/v2/everything?q=Apple&sortBy=publishedAt&apiKey=ac6527acf98841cc92c111997368da4d';

//   // Make the request with http.get()
//   final response1 = await http.get(Uri.parse(url));

//   // Check if the request was successful
//   if (response1.statusCode == 200) {
//     // Parse the JSON response to get the first search result
//     final firstResult = response1.body['articles'][0];

//     // Make a new request to get the article HTML
//     final response2 = await http.get(Uri.parse(firstResult['url']));

//     // Check if the second request was successful
//     if (response2.statusCode == 200) {
//       // Use html_parser to parse the HTML and convert it into a DOM object
//       final dom =
//           html_parser.parse(response2.body, sourceUrl: firstResult['url']);

//       // Now, extract the article content using @mozilla/readability logic
//       final article = extractArticleContent(dom);

//       // Done! The article content is in the textContent property
//       print(article);
//     }
//   }
// }

// String extractArticleContent(html_dom.Document dom) {
//   // Use @mozilla/readability logic to locate the article content
//   // Assuming Readability class has been implemented in your Dart project
//   // You may need to explore or create a Dart package that provides Readability functionality

//   // Example:
//   // Readability readability = Readability(dom);
//   // return readability.textContent;

//   // In the absence of a Dart package for Readability, you might need to implement
//   // or adapt the Readability logic for Dart, or explore other Dart packages providing
//   // similar functionality.
//   return 'Article content extraction logic needs to be implemented.';
// }
