import 'package:flutter/material.dart';
import 'public_chat_room_screen.dart';

class Community {
  final String name;
  final Color color;
  final String imagePath; // Property for the image path

  Community({required this.name, required this.color, required this.imagePath});
}

class CommunityScreen extends StatelessWidget {
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
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.0,
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
                      communityName: community.name,
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
                    Opacity(
                      opacity: 0.6,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          community.imagePath,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        community.name,
                        style: TextStyle(
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
