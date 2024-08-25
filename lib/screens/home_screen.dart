import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'public_chat_room_screen.dart';
import 'mood_tracker_screen.dart';
import 'community_screen.dart';
import 'educational_resources_screen.dart'; // Import the Educational Resources Screen

class Community {
  final String name;
  final Color color;
  final String imagePath;

  Community({required this.name, required this.color, required this.imagePath});
}

class EducationalResource {
  final String title;
  final String description;
  final String url;

  EducationalResource({
    required this.title,
    required this.description,
    required this.url,
  });
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final List<Community> communities = [
    Community(
        name: "Calm Minds",
        color: Colors.blueAccent,
        imagePath: 'assets/images/calm_minds.jpg'),
    Community(
        name: "Hopeful Hearts",
        color: Colors.pinkAccent,
        imagePath: 'assets/images/hopeful_hearts.jpg'),
    Community(
        name: "Serene Souls",
        color: Colors.greenAccent,
        imagePath: 'assets/images/serene_souls.jpg'),
  ];

  final List<EducationalResource> educationalResources = [
    EducationalResource(
      title: 'Understanding Anxiety',
      description:
          'Learn about the causes, symptoms, and treatments for anxiety.',
      url: 'https://www.example.com/anxiety',
    ),
    EducationalResource(
      title: 'Coping with Depression',
      description: 'Strategies and resources for managing depression.',
      url: 'https://www.example.com/depression',
    ),
    EducationalResource(
      title: 'Mindfulness Practices',
      description: 'Techniques to practice mindfulness and reduce stress.',
      url: 'https://www.example.com/mindfulness',
    ),
    EducationalResource(
      title: 'Healthy Sleep Habits',
      description: 'Tips for improving sleep quality and managing insomnia.',
      url: 'https://www.example.com/sleep',
    ),
    EducationalResource(
      title: 'Building Resilience',
      description: 'How to develop resilience in the face of adversity.',
      url: 'https://www.example.com/resilience',
    ),
  ];

  final PageController _pageController = PageController(viewportFraction: 0.75);

  int _selectedMood = 4; // Default to Awful
  final List<String> moods = ["Rad", "Good", "Meh", "Bad", "Awful"];
  final List<IconData> moodIcons = [
    Icons.sentiment_very_satisfied,
    Icons.sentiment_satisfied,
    Icons.sentiment_neutral,
    Icons.sentiment_dissatisfied,
    Icons.sentiment_very_dissatisfied
  ];
  final List<Color> moodColors = [
    Colors.yellow,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.red,
  ];

  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController?.dispose();
    super.dispose();
  }

  void _updateMood(int index) {
    setState(() {
      _selectedMood = index;
      _animationController?.reset();
      _animationController?.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: ListView(
        children: [
          // Mood Tracker Bar with Explore Arrow
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mood Tracker',
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
                          builder: (context) => MoodTrackerScreen()),
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        'Explore',
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

          // "How was your day today?" Label
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'How was your day today?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Horizontal Row for Mood Selection
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(moods.length, (index) {
                final isSelected = _selectedMood == index;
                final scale = isSelected ? 1.2 : 1.0;

                return GestureDetector(
                  onTap: () {
                    _updateMood(index);
                  },
                  child: Column(
                    children: [
                      AnimatedScale(
                        scale: scale,
                        duration: Duration(milliseconds: 200),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color:
                                  isSelected ? moodColors[index] : Colors.grey,
                              width: 3,
                            ),
                          ),
                          child: Icon(
                            moodIcons[index],
                            color: isSelected ? moodColors[index] : Colors.grey,
                            size: 60,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        moods[index],
                        style: TextStyle(
                          color: isSelected ? moodColors[index] : Colors.grey,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),

          // Community Bar with Explore Arrow
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
                        'Explore',
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

          // Horizontal Slider for Community Cards
          Container(
            height: 250, // Adjust the height as needed
            child: PageView.builder(
              controller: _pageController,
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
                    width: 200, // Adjust the width as needed
                    margin: EdgeInsets.only(right: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            community.imagePath,
                            fit: BoxFit.cover,
                          ),
                          Center(
                            child: Text(
                              community.name,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 5.0,
                                    color: Colors.black.withOpacity(0.5),
                                    offset: Offset(2.0, 2.0),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Educational Resources Bar with Explore Arrow
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Educational Resources',
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
                          builder: (context) => EducationalResourcesScreen()),
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        'Explore',
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

          // Horizontal Slider for Educational Resource Cards without Image
          Container(
            height: 250, // Increased height to provide more space
            padding: EdgeInsets.only(
                bottom: 20.0), // Add bottom padding to prevent touching bottom
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: educationalResources.length,
              itemBuilder: (context, index) {
                final resource = educationalResources[index];
                return GestureDetector(
                  onTap: () {
                    // Handle resource selection, e.g., open a web view or navigate to another screen
                    // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen(url: resource.url)));
                  },
                  child: Container(
                    width:
                        300, // Increased width for more space within each card
                    margin: EdgeInsets.symmetric(
                        horizontal: 16.0), // Increased horizontal margin
                    padding: EdgeInsets.all(
                        20.0), // Increased padding inside the card
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: Offset(0, 4),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Remove image asset
                          SizedBox(height: 10),
                          Text(
                            resource.title,
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 10),
                          Text(
                            resource.description,
                            style: GoogleFonts.ptSansNarrow(
                              fontSize: 18,
                              color: Colors.white70,
                            ),
                            // Remove maxLines to allow scrolling if needed
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}