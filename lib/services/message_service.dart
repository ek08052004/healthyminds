// services/message_service.dart
import 'api_service.dart';
import '../models/message.dart';

class MessageService {
  static Future<List<Message>> fetchMessages(String chatId) async {
    final response = await ApiService.get('/api/message/$chatId');
    return (response as List).map((msg) => Message.fromJson(msg)).toList();
  }

  static Future<Message> sendMessage(String content, String chatId) async {
    final response = await ApiService.post('/api/message', {'content': content, 'chatId': chatId});
    return Message.fromJson(response);
  }
}
