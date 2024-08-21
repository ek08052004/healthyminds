import 'package:flutter/material.dart';
import 'upload_image_screen.dart';
import '../widgets/image_grid.dart';
import '../models/vision_image.dart';

class VisionBoardScreen extends StatefulWidget {
  @override
  _VisionBoardScreenState createState() => _VisionBoardScreenState();
}

class _VisionBoardScreenState extends State<VisionBoardScreen> {
  List<VisionImage> _images = [];

  void _addImage(String path) {
    if (_images.length < 6) {  // Limit the number of images to 6
      setState(() {
        _images.add(VisionImage(path: path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Vision Board'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/memoryframes.jpg'), // Background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (_images.isEmpty)
            Center(
              child: Text('No images yet, add some!'),
            )
          else
            ImageGrid(images: _images), // Display images on the frames
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final imagePath = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UploadImageScreen(imageCount: _images.length),
            ),
          );

          if (imagePath != null) {
            _addImage(imagePath);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
