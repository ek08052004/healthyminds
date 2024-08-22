import 'package:flutter/material.dart';
import 'vision_board_screen.dart';
import 'mood_tracker_screen.dart';
import 'future_letter_screen.dart';
import 'public_chat_room_screen.dart'; // Import the PublicChatRoomScreen

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor:
            const Color.fromARGB(255, 150, 123, 182), // Darker purple
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications here
              print('Notifications clicked');
            },
          ),
          GestureDetector(
            onTap: () {
              // Handle profile action here
              print('Profile clicked');
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.deepPurpleAccent),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      backgroundColor: const Color.fromARGB(
          255, 186, 165, 221), // Set a lighter purple background
      body: Column(
        children: [
          _buildQuoteCard(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  _buildMenuItem(
                    context,
                    'Vision Board',
                    VisionBoardScreen(),
                    Icons.dashboard,
                    Colors.pinkAccent,
                    Colors.white,
                  ),
                  _buildMenuItem(
                    context,
                    'Mood Tracker',
                    MoodTrackerScreen(),
                    Icons.sentiment_satisfied,
                    Colors.lightBlueAccent,
                    Colors.white,
                  ),
                  _buildMenuItem(
                    context,
                    'Future Letter',
                    FutureLetterScreen(),
                    Icons.mail,
                    Colors.greenAccent,
                    Colors.white,
                  ),
                  _buildMenuItem(
                    context,
                    'Chat Room',
                    PublicChatRoomScreen(),
                    Icons.chat,
                    Colors.purpleAccent,
                    Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuoteCard() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purpleAccent, Colors.deepPurpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '"What if you moved through the world as if you were easy to be loved? Because I promise you, you are easy to love."',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              '- Sonalee Rashatwar, LCSW',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String text,
    Widget screen,
    IconData icon,
    Color backgroundColor,
    Color textColor,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => screen,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: textColor),
            SizedBox(height: 10),
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
