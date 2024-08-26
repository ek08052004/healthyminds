import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class VisionBoardScreen extends StatefulWidget {
  @override
  _VisionBoardScreenState createState() => _VisionBoardScreenState();
}

class _VisionBoardScreenState extends State<VisionBoardScreen> {
  final ImagePicker _picker = ImagePicker();
  List<File?> _photos = List<File?>.filled(6, null);

  final List<Color> _wallColors = [
    Colors.red[300]!,
    Colors.green[300]!,
    Colors.blue[300]!,
    Colors.yellow[300]!,
    Colors.orange[300]!,
    Colors.purple[300]!,
  ];

  Future<void> _pickImage(int index) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _photos[index] = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vision Board'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Text
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'MY GOALS',
                style: GoogleFonts.gloriaHallelujah(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[900],
                ),
              ),
            ),
            // Wall Layout
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 walls per row
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              padding: const EdgeInsets.all(16.0),
              itemCount: _photos.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _pickImage(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _wallColors[index],
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: Offset(2, 4), // Shadow position
                        ),
                      ],
                    ),
                    child: _photos[index] == null
                        ? Center(
                            child: Icon(Icons.add_photo_alternate, color: Colors.white70),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.file(
                              _photos[index]!,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover, // Ensures the image fits the wall completely
                            ),
                          ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
