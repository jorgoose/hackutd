import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class OpenAIService {
final String _baseURL = 'https://api.openai.com/v1/chat/completions';

  Future<String> getResponse(String prompt) async {
    print(prompt);
    // String apiKey = dotenv.env['OPENAI_API_KEY'] ?? "Your_Default_API_Key_Here";
    final String _apiKey = dotenv.env['OPENAI_API_KEY'] ?? "fuck typing";
    print(_apiKey);

    try {
      final response = await http.post(
        Uri.parse(_baseURL),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [{"role": "user", "content": prompt}]
        }),
      );

      print(response.body);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData['choices'][0]['message']['content'];
      } else {
        // Consider using a custom error type or handling to improve error feedback
        return 'Error: ${response.statusCode} ${response.reasonPhrase}';
      }
    } catch (e) {
      // Consider using a custom error type or handling to improve error feedback
      return 'Error: $e';
    }
  }
}
