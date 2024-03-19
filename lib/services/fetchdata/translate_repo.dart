import 'package:google_generative_ai/google_generative_ai.dart';

Future<String?> getAnswer({required String content}) async {
  final model = GenerativeModel(
      model: 'gemini-pro', apiKey: "AIzaSyA2iovC52mjI7MoHBQhkuQiSLBjFusCh8o");
  final ctn = [
    Content.text(
        "translate the value of this json to vietnamese and give me the same json: $content")
  ];
  final response = await model.generateContent(ctn);
  print(response);
  return response.text;
}
