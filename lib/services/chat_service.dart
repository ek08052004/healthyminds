import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/auth_utils.dart';

class ChatService {
  final String baseUrl = "http://10.0.2.2:5000/api";  // Replace with your backend URL

  Future<List<ChatRoom>> fetchChatRooms() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/chat/groups"));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        if (data is List) {
          return data.map((item) {
            if (item is Map<String, dynamic>) {
              return ChatRoom.fromJson(item);
            } else {
              throw Exception("Unexpected item type: ${item.runtimeType}");
            }
          }).toList();
        } else {
          throw Exception("Unexpected response format: ${data.runtimeType}");
        }
      } else {
        throw Exception("Failed to load chat rooms, status code: ${response.statusCode}");
      }
    } catch (error) {
      throw Exception("Failed to load chat rooms: $error");
    }
  }

Future<void> joinChatRoom(String chatRoomId) async {
  try {
    final token = await AuthUtils.getAuthToken();
    if (token == null) {
      throw Exception("Authentication token is missing.");
    }

    final url = Uri.parse("$baseUrl/chat/join");
    print("Request URL: $url");

    final body = jsonEncode({'chatId': chatRoomId});
    print("Request Body: $body");

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: body,
    );

    print("Response Status: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode != 200) {
      throw Exception("Failed to join chat room, status code: ${response.statusCode}");
    }
  } catch (error) {
    throw Exception("Failed to join chat room: $error");
  }
}


  Future<void> sendMessage(String content, String chatId) async {
    try {
      final token = await AuthUtils.getAuthToken();
      if (token == null) {
        throw Exception("Authentication token is missing.");
      }

      final response = await http.post(
        Uri.parse("$baseUrl/message"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'content': content, 'chatId': chatId}),
      );

      if (response.statusCode != 200) {
        throw Exception("Failed to send message, status code: ${response.statusCode}");
      }
    } catch (error) {
      throw Exception("Failed to send message: $error");
    }
  }

  Future<List<Message>> fetchMessages(String chatId) async {
    try {
      final token = await AuthUtils.getAuthToken();
      if (token == null) {
        throw Exception("Authentication token is missing.");
      }

      final response = await http.get(
        Uri.parse("$baseUrl/message/$chatId"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        if (data is List) {
          return data.map((item) {
            if (item is Map<String, dynamic>) {
              return Message.fromJson(item);
            } else {
              throw Exception("Unexpected item type: ${item.runtimeType}");
            }
          }).toList();
        } else {
          throw Exception("Unexpected response format: ${data.runtimeType}");
        }
      } else {
        throw Exception("Failed to load messages, status code: ${response.statusCode}");
      }
    } catch (error) {
      throw Exception("Failed to load messages: $error");
    }
  }
 
}

// Define ChatRoom and User classes specific to chat operations
class ChatRoom {
  final String id;
  final String name;
  final List<User> users;

  ChatRoom({required this.id, required this.name, required this.users});

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      id: json['_id'],
      name: json['chatName'],
      users: (json['users'] as List<dynamic>)
          .map((userJson) => User.fromJson(userJson))
          .toList(),
    );
  }
}

class User {
  final String id;
  final String name;
  final String email;

  User({
    required this.id,
    this.name = '',      // Provide default empty value if not supplied
    this.email = '',     // Provide default empty value if not supplied
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',  // Default to empty string if '_id' is missing
      name: json['name'] ?? '',  // Default to empty string if 'name' is missing
      email: json['email'] ?? '',  // Default to empty string if 'email' is missing
    );
  }
}

 
class Message {
  final String sender;
  final String content;

  Message({
    required this.sender,
    required this.content,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      sender: json['sender']?['name'] ?? '', // Use null-aware operator to handle nulls
      content: json['content'] ?? '', // Default to empty string if null
    );
  }
}
