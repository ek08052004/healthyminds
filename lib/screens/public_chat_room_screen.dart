import 'package:flutter/material.dart';

class PublicChatRoomScreen extends StatefulWidget {
  @override
  _PublicChatRoomScreenState createState() => _PublicChatRoomScreenState();
}

class _PublicChatRoomScreenState extends State<PublicChatRoomScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add(_controller.text);
        _controller.clear(); // Clear the input field after sending
      });
    }
  }

  void _handleMenuSelection(String value, String message) {
    // Handle menu selections here
    switch (value) {
      case 'friend_request':
        // Logic to send a friend request
        print('Friend request sent for message: $message');
        break;
      case 'block':
        // Logic to block the user
        print('User blocked for message: $message');
        break;
      case 'report':
        // Logic to report the message/user
        print('Message reported: $message');
        break;
    }
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
                return ChatMessage(
                  message: _messages[index],
                  onMenuSelected: _handleMenuSelection,
                );
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
  final Function(String, String) onMenuSelected;

  ChatMessage({
    required this.message,
    required this.onMenuSelected,
  });

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
          PopupMenuButton<String>(
            onSelected: (value) => onMenuSelected(value, message),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'friend_request',
                  child: Text('Send Friend Request'),
                ),
                PopupMenuItem(
                  value: 'block',
                  child: Text('Block User'),
                ),
                PopupMenuItem(
                  value: 'report',
                  child: Text('Report Message'),
                ),
              ];
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }
}
