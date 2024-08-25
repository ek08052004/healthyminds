import 'package:flutter/material.dart';
import '../services/chat_service.dart';

class ChatRoomScreen extends StatefulWidget {
  final ChatRoom chatRoom;

  ChatRoomScreen({required this.chatRoom});

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    _fetchMessages();
  }

  void _fetchMessages() async {
    try {
      final messages = await ChatService().fetchMessages(widget.chatRoom.id);
      setState(() {
        _messages = messages;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to load messages")));
    }
  }

  void _sendMessage() async {
    String message = _controller.text;

    if (message.isNotEmpty) {
      setState(() {
        _messages.add(Message(sender: "You", content: message));
        _controller.clear();
      });

      try {
        await ChatService().sendMessage(message, widget.chatRoom.id);
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to send message")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.chatRoom.name)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Text(message.content),
                  subtitle: Text(message.sender),
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
                    decoration: InputDecoration(labelText: 'Enter message'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
