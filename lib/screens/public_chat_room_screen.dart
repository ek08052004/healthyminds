import 'package:flutter/material.dart';
import '../services/chat_moderation_service.dart'; // Import the moderation service

class PublicChatRoomScreen extends StatefulWidget {
  @override
  _PublicChatRoomScreenState createState() => _PublicChatRoomScreenState();
}

class _PublicChatRoomScreenState extends State<PublicChatRoomScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];
  final ChatModerationService _moderationService = ChatModerationService();

  void _sendMessage() async {
    String message = _controller.text;

    if (message.isNotEmpty) {
      try {
        bool isSafe = await _moderationService.isMessageSafe(message);

        if (isSafe) {
          setState(() {
            _messages.add(message);
            _controller.clear(); // Clear the input field after sending
          });
        } else {
          _showWarningDialog(); // Show a warning if the message is harmful
        }
      } catch (e) {
        // Handle any errors that occur during moderation
        print("Error moderating message: $e");
        _showErrorDialog();
      }
    }
  }

  void _showWarningDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Message Blocked'),
          content: Text('Your message was blocked as it was deemed harmful.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(
              'There was an error moderating your message. Please try again later.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Public Chat Room'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ChatMessage(message: _messages[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage, // Send message on button press
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String message;

  ChatMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(child: Icon(Icons.person)),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(message),
            ),
          ),
        ],
      ),
    );
  }
}
