import 'package:flutter/material.dart';
import 'public_chat_room_screen.dart';

// Define the Community class
class Community {
  final String name;
  final Color color;

  Community({required this.name, required this.color});
}

class CommunityScreen extends StatelessWidget {
  final List<Community> communities = [
    Community(name: "Calm Minds", color: Colors.blueAccent),
    Community(name: "Hopeful Hearts", color: Colors.pinkAccent),
    Community(name: "Serene Souls", color: Colors.greenAccent),
  ];

  // Helper function to generate the image path
  String getImagePath(String communityName) {
    String formattedName = communityName.toLowerCase().replaceAll(' ', '_');
    return 'assets/images/$formattedName.jpg';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Communities'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 items per row
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.0, // Square-shaped items
          ),
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    // Background Image with reduced opacity
                    Opacity(
                      opacity:
                          0.6, // Adjust the opacity to make the image very light
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          getImagePath(community
                              .name), // Dynamically load background image
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                    // Community Name Text
                    Center(
                      child: Text(
                        community.name,
                        style: TextStyle(
                          fontFamily: 'CustomFont', // Use custom font
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
            );
          },
        ),
      ),
    );
  }
}
