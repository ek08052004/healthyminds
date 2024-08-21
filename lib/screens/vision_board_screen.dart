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
    setState(() {
      _images.add(VisionImage(path: path));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Vision Board'),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          ),
        ],
      ),
      body: _images.isEmpty
          ? Center(
              child: Text('No images yet, add some!'),
            )
          : Container(
              color: Colors.green[100], // Green background for the vision board
              child: ImageGrid(images: _images),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final imagePath = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    UploadImageScreen(imageCount: _images.length)),
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
