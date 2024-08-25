import 'package:flutter/material.dart';

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
