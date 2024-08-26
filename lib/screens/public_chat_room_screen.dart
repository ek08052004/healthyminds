import 'package:flutter/material.dart';

class PublicChatRoomScreen extends StatefulWidget {
  final String communityName; // Add the communityName parameter

  PublicChatRoomScreen({required this.communityName}); // Update the constructor

  @override
  _PublicChatRoomScreenState createState() => _PublicChatRoomScreenState();
}

class _PublicChatRoomScreenState extends State<PublicChatRoomScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];

  void _sendMessage() {
    String message = _controller.text;

    if (message.isNotEmpty) {
      setState(() {
        _messages.add(message);
        _controller.clear(); // Clear the input field after sending
      });
    }
  }

  void _sendFriendRequest(String message) {
    // Implement the logic for sending a friend request
    print('Friend request sent for message: $message');
  }

  void _reportMessage(String message) {
    // Implement the logic for reporting the message
    print('Message reported: $message');
  }

  void _blockUser(String message) {
    // Implement the logic for blocking the user
    print('User blocked for message: $message');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${widget.communityName} Chat Room'), // Use the communityName parameter
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
                  onSendFriendRequest: _sendFriendRequest,
                  onReport: _reportMessage,
                  onBlock: _blockUser,
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
  final Function(String) onSendFriendRequest;
  final Function(String) onReport;
  final Function(String) onBlock;

  ChatMessage({
    required this.message,
    required this.onSendFriendRequest,
    required this.onReport,
    required this.onBlock,
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
            onSelected: (String result) {
              switch (result) {
                case 'Send Friend Request':
                  onSendFriendRequest(message);
                  break;
                case 'Report':
                  onReport(message);
                  break;
                case 'Block':
                  onBlock(message);
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Send Friend Request',
                child: Text('Send Friend Request'),
              ),
              const PopupMenuItem<String>(
                value: 'Report',
                child: Text('Report'),
              ),
              const PopupMenuItem<String>(
                value: 'Block',
                child: Text('Block'),
              ),
            ],
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }
}
