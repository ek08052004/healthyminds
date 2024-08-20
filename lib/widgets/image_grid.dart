import 'package:flutter/material.dart';
import 'image_tile.dart';
import '../models/vision_image.dart';

class ImageGrid extends StatelessWidget {
  final List<VisionImage> images;

  ImageGrid({required this.images});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 columns in the grid
        childAspectRatio: 1,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return ImageTile(imagePath: images[index].path);
      },
    );
  }
}
