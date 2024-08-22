import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts package
import 'mood_tracker_screen.dart';
import 'vision_board_screen.dart';
<<<<<<< HEAD
import 'future_letter_screen.dart';
=======
import 'mood_tracker_screen.dart';
import 'future_letter_screen.dart';
import 'public_chat_room_screen.dart'; // Import the PublicChatRoomScreen
>>>>>>> e4fea18f45cbeb67cdee7b730d8dac97e5c47a35

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
=======
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
>>>>>>> e4fea18f45cbeb67cdee7b730d8dac97e5c47a35
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
<<<<<<< HEAD
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
=======
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
>>>>>>> e4fea18f45cbeb67cdee7b730d8dac97e5c47a35
      ),
    );
  }

<<<<<<< HEAD
  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
    Widget screen,
=======
  Widget _buildMenuItem(
    BuildContext context,
    String text,
    Widget screen,
    IconData icon,
    Color backgroundColor,
    Color textColor,
>>>>>>> e4fea18f45cbeb67cdee7b730d8dac97e5c47a35
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
<<<<<<< HEAD
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
=======
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
>>>>>>> e4fea18f45cbeb67cdee7b730d8dac97e5c47a35
            ),
          ],
        ),
      ),
    );
  }
}
