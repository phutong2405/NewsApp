import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';

Future<String> getAnswer({required String content}) async {
  // final apiKey =
  //     Platform.environment['AIzaSyA2iovC52mjI7MoHBQhkuQiSLBjFusCh8o'];
  // if (apiKey == null) {
  //   print('No \$API_KEY environment variable');
  //   return "";
  // }
  // For text-only input, use the gemini-pro model
  final model = GenerativeModel(
      model: 'gemini-pro', apiKey: "AIzaSyA2iovC52mjI7MoHBQhkuQiSLBjFusCh8o");
  final ctn = [Content.text("Dịch sang tiếng việt đoạn này: $content")];
  final response = await model.generateContent(ctn);
  return response.text!;
}
