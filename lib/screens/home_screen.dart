import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'mood_tracker_screen.dart';
import 'community_screen.dart';
import 'educational_resources_screen.dart'; // Import the Educational Resources Screen
import 'vision_board_screen.dart'; // Import Vision Board Screen
import 'future_letter_screen.dart';
import 'chat_rooms_list_screen.dart'; // Updated import for the chat rooms list
import '../utils/auth_utils.dart'; // Import AuthUtils for token checking

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    checkToken();
  }

  void checkToken() async {
    bool tokenExists = await AuthUtils.isTokenStored();

    if (tokenExists) {
      print('Token is stored.');
      // Proceed with authenticated actions or load home screen data
    } else {
      print('No token found.');
      // Redirect to login or show a login screen
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                          child: Icon(
                            moodIcons[index],
                            color: isSelected ? moodColors[index] : Colors.grey,
                            size: 50, // Reduced size
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          moods[index],
                          style: TextStyle(
                            color: isSelected ? moodColors[index] : Colors.grey,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
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
                            communityName:
                                community.name, // Pass community name
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
                    'Articles Feed',
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

            // Horizontal Slider for Educational Resources Cards
            Container(
              height: 200, // Adjust the height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: educationalResources.length,
                itemBuilder: (context, index) {
                  final resource = educationalResources[index];
                  return Container(
                    width: 150, // Adjust the width as needed
                    margin: EdgeInsets.only(right: 16.0),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          resource.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          resource.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            // Handle link tap
                          },
                          child: Text(
                            'Read More',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Relive Your Moments Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Relive Your Moments',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

// Box Around Animation and Button Below "Promise to Yourself"
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Lottie.asset(
                        'assets/animations/animationvision.json', // Replace with your animation file
                        height: 200,
                        width: 250,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          backgroundColor: Colors.blueAccent,
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VisionBoardScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Add a New Memory!',
                          style: GoogleFonts.robotoCondensed(
                            textStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

// Box Around Animation Below "Promise to Yourself"
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Promise To Yourself',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

// Box Around Animation and Button Below "Promise to Yourself"
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Lottie.asset(
                        'assets/animations/Animationfutureletter.json', // Replace with your animation file
                        height: 200,
                        width: 250,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          backgroundColor: Colors.blueAccent,
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FutureLetterScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Write a Promise!',
                          style: GoogleFonts.robotoCondensed(
                            textStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
