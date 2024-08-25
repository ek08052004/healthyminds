import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart'; // Import HomeScreen
import 'screens/mood_tracker_screen.dart'; // Import MoodTrackerScreen
import 'screens/vision_board_screen.dart'; // Import VisionBoardScreen
import 'screens/future_letter_screen.dart'; // Import FutureLetterScreen
import 'screens/chat_rooms_list_screen.dart'; // Import ChatRoomsListScreen
import 'screens/chat_room_screen.dart'; // Import ChatRoomScreen
import 'services/chat_service.dart'; // Import ChatRoom model

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vision Board',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), // Set SplashScreen as the home widget
      initialRoute: '/home', // Set the initial route
      routes: {
        '/home': (context) => HomeScreen(),
        '/tracker': (context) => MoodTrackerScreen(),
        '/vision': (context) => VisionBoardScreen(),
        '/memory': (context) => FutureLetterScreen(),
        '/chat_rooms': (context) => ChatRoomsListScreen(), // Add ChatRoomsListScreen route
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/chat_room') {
          final ChatRoom chatRoom = settings.arguments as ChatRoom;
          return MaterialPageRoute(
            builder: (context) => ChatRoomScreen(chatRoom: chatRoom),
          );
        }
        return null; // Return null if the route is not handled
      },
    );
  }
}
