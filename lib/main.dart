import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart'; // Import HomeScreen
import 'screens/mood_tracker_screen.dart'; // Import MoodTrackerScreen
import 'screens/vision_board_screen.dart'; // Import VisionBoardScreen
import 'screens/future_letter_screen.dart'; // Import FutureLetterScreen
import 'screens/public_chat_room_screen.dart'; // Import PublicChatRoomScreen

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
        '/chat': (context) => PublicChatRoomScreen(), // Add PublicChatRoomScreen route
      },
    );
  }
}
