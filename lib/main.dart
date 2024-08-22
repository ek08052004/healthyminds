import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // Import HomeScreen
import 'screens/mood_tracker_screen.dart'; // Import MoodTrackerScreen
import 'screens/vision_board_screen.dart'; // Import VisionBoardScreen
import 'screens/future_letter_screen.dart'; // Import FutureLetterScreen
 // Placeholder for ProfileScreen

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
      initialRoute: '/home', // Set the initial route
      routes: {
        '/home': (context) => HomeScreen(),
        // Placeholder, replace with actual implementation
        '/tracker': (context) => MoodTrackerScreen(),
        // Placeholder, replace with actual implementation
         // Placeholder, replace with actual implementation
        '/vision': (context) => VisionBoardScreen(),
        '/memory': (context) => FutureLetterScreen(),
      },
    );
  }
}
