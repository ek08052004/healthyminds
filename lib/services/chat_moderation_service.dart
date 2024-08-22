import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class ChatModerationService {
  final String _apiUrl = 'https://api.openai.com/v1/moderations';
  final String _apiKey = Platform.environment['OPENAI_API_KEY'] ??
      ''; // Retrieve from environment variables

  Future<bool> isMessageSafe(String message) async {
    if (_apiKey.isEmpty) {
      throw Exception('API key is not set.');
    }

    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        'input': message,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return !data['results'][0]
          ['flagged']; // Return true if the message is not flagged
    } else {
      throw Exception('Failed to moderate message: ${response.statusCode}');
    }
  }
}
