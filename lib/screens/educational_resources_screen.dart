import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

class EducationalResourcesScreen extends StatefulWidget {
  @override
  _EducationalResourcesScreenState createState() =>
      _EducationalResourcesScreenState();
}

class _EducationalResourcesScreenState
    extends State<EducationalResourcesScreen> {
  final List<EducationalResource> resources = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Educational Resources'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: resources.length,
        itemBuilder: (context, index) {
          final resource = resources[index];
          return Container(
            margin: EdgeInsets.only(bottom: 16.0),
            padding: EdgeInsets.all(16.0),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  resource.title,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  resource.description,
                  style: GoogleFonts.ptSansNarrow(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
