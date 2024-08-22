import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts package
import 'mood_tracker_screen.dart';
import 'vision_board_screen.dart';
import 'future_letter_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Message Section
          Container(
            color: Colors.white, // White background
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  'Welcome Back Ekansh',
                  style: GoogleFonts.oswald(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[900],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Daily Tip: Remember to take deep breaths and relax today.',
                  style: GoogleFonts.ptSansNarrow(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),

          // Tools Section
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            color: Colors.grey[200],
            child: Row(
              children: [
                Icon(Icons.build, color: Colors.blueGrey, size: 24),
                SizedBox(width: 8),
                Text(
                  'OUR TOOLS',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[800],
                  ),
                ),
              ],
            ),
          ),

          // Feature Cards Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  _buildFeatureCard(
                    context,
                    'Mood Tracker',
                    'Track your daily moods and see the trend.',
                    Icons.sentiment_satisfied,
                    Colors.lightGreen,
                    MoodTrackerScreen(),
                  ),
                  SizedBox(height: 16), // Spacing between cards
                  _buildFeatureCard(
                    context,
                    'Vision Board',
                    'Create a board of your future goals and dreams.',
                    Icons.pin_drop_rounded,
                    Colors.orange,
                    VisionBoardScreen(),
                  ),
                  SizedBox(height: 16), // Spacing between cards
                  _buildFeatureCard(
                    context,
                    'Memory Lane',
                    'Relive your favorite memories through this feature.',
                    Icons.photo_album,
                    Colors.blue,
                    FutureLetterScreen(), // Placeholder, adjust as necessary
                  ),
                  SizedBox(height: 16), // Spacing between cards
                  _buildFeatureCard(
                    context,
                    'Educational Resources',
                    'Access various mental health resources.',
                    Icons.book,
                    Colors.purple,
                    FutureLetterScreen(), // Placeholder, adjust as necessary
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.purple, // Set the background color to purple
        selectedItemColor: Colors.purple, // Color of selected item
        unselectedItemColor: Colors.purple, // Color of unselected items
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Tracker',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Resources',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/messages');
              break;
            case 2:
              Navigator.pushNamed(context, '/tracker');
              break;
            case 3:
              Navigator.pushNamed(context, '/resources');
              break;
            case 4:
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
    Widget screen,
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
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: Offset(0, 4),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 20, // Larger font size for the title
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    description,
                    style: GoogleFonts.ptSansNarrow(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              icon,
              color: Colors.white,
              size: 50, // Adjust icon size for a balanced look
            ),
          ],
        ),
      ),
    );
  }
}
