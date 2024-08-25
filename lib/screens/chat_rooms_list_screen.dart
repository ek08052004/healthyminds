import 'package:flutter/material.dart';
import '../services/chat_service.dart';
import 'chat_room_screen.dart';

class ChatRoomsListScreen extends StatefulWidget {
  @override
  _ChatRoomsListScreenState createState() => _ChatRoomsListScreenState();
}

class _ChatRoomsListScreenState extends State<ChatRoomsListScreen> {
  late Future<List<ChatRoom>> _chatRooms;
  final String currentUserId = "66cad58a1153d83ba4411d93"; // Replace with actual user ID

  @override
  void initState() {
    super.initState();
    _chatRooms = ChatService().fetchChatRooms();
  }

  void _joinChatRoom(ChatRoom room) async {
    try {
      print("Attempting to join chat room with ID: ${room.id}");

      // Ensure this method completes successfully
      await ChatService().joinChatRoom(room.id);

      setState(() {
        // Create a new User object using the ID
        User newUser = User(id: currentUserId);
        room.users.add(newUser);

        print("User added to room: ${newUser.id}");
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChatRoomScreen(chatRoom: room)),
      );

      print("Navigation to chat room screen successful.");
    } catch (error) {
      print("Failed to join chat room: $error");  // Log the error

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to join room: $error")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat Rooms")),
      body: FutureBuilder<List<ChatRoom>>(
        future: _chatRooms,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading chat rooms"));
          } else {
            final rooms = snapshot.data ?? [];
            return ListView.builder(
              itemCount: rooms.length,
              itemBuilder: (context, index) {
                final room = rooms[index];
                final isJoined = room.users.any((user) => user.id == currentUserId);

                return ListTile(
                  title: Text(room.name),
                  trailing: isJoined
                    ? ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChatRoomScreen(chatRoom: room)),
                          );
                        },
                        child: Text("Enter"),
                      )
                    : ElevatedButton(
                        onPressed: () => _joinChatRoom(room),
                        child: Text("Join"),
                      ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
