import 'package:flutter/material.dart';
import 'image_tile.dart';
import '../models/vision_image.dart';

class ImageGrid extends StatelessWidget {
  final List<VisionImage> images;

  ImageGrid({required this.images});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // First Image Frame Position and Size
        if (images.isNotEmpty)
          ImageTile(
            imagePath: images[0].path,
            top: 50,
            left: 30,
            width: 100,
            height: 150,
          ),
        // Second Image Frame Position and Size
        if (images.length > 1)
          ImageTile(
            imagePath: images[1].path,
            top: 220,
            left: 140,
            width: 120,
            height: 180,
          ),
        // Third Image Frame Position and Size
        if (images.length > 2)
          ImageTile(
            imagePath: images[2].path,
            top: 430,
            left: 70,
            width: 150,
            height: 200,
          ),
        // Additional images with similar positioning logic...
        // ...
      ],
    );
  }
}
