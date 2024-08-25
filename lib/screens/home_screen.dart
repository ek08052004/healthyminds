import 'package:flutter/material.dart';
import 'community_screen.dart';
import 'public_chat_room_screen.dart';
import 'mood_tracker_screen.dart'; // Ensure this is imported

class HomeScreen extends StatelessWidget {
  final List<Community> communities = [
    Community(name: "Calm Minds", color: Colors.blueAccent),
    Community(name: "Hopeful Hearts", color: Colors.pinkAccent),
    Community(name: "Serene Souls", color: Colors.greenAccent),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: ListView(
        children: [
          // Community Bar with See More Arrow
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Communities',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CommunityScreen()),
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        'See More',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                      ),
                      Icon(Icons.arrow_forward, color: Colors.blue),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Horizontal Slider for Community Cards with Snapping
          Container(
            height: 200, // Adjust the height as needed
            child: PageView.builder(
              controller: PageController(viewportFraction: 0.7),
              itemCount: communities.length,
              itemBuilder: (context, index) {
                final community = communities[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PublicChatRoomScreen(
                          communityName: community.name, // Pass community name
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: community.color,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        community.name,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Horizontal Scroll for Other Feature Cards
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFeatureCard(
                    context,
                    'Mood Tracker',
                    'Track your daily moods and see the trend.',
                    Icons.sentiment_satisfied,
                    Colors.lightGreen,
                    MoodTrackerScreen(),
                  ),
                  SizedBox(width: 10), // Space between cards
                  _buildFeatureCard(
                    context,
                    'Vision Board',
                    'Create and visualize your goals.',
                    Icons.dashboard,
                    Colors.orangeAccent,
                    Container(), // Placeholder for Vision Board screen
                  ),
                  SizedBox(width: 10), // Space between cards
                  _buildFeatureCard(
                    context,
                    'Daily Journal',
                    'Write your thoughts and feelings.',
                    Icons.book,
                    Colors.purpleAccent,
                    Container(), // Placeholder for Daily Journal screen
                  ),
                  // Add more feature cards here...
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
          BottomNavigationBarItem(
              icon: Icon(Icons.trending_up), label: 'Tracker'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Resources'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
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
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Container(
        width: 250, // Set a fixed width for the feature card
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 6,
              offset: Offset(0, 4),
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
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            Icon(icon, color: Colors.white, size: 50),
          ],
        ),
      ),
    );
  }
}