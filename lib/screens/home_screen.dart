import 'package:flutter/material.dart';
import 'vision_board_screen.dart';
import 'mood_tracker_screen.dart'; // Import MoodTrackerScreen

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VisionBoardScreen(),
                  ),
                );
              },
              child: Text('Go to Vision Board'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MoodTrackerScreen(),
                  ),
                );
              },
              child: Text('Go to Mood Tracker'),
            ),
          ],
        ),
      ),
    );
  }
}
