import 'dart:io';
import 'package:flutter/material.dart';

class ImageTile extends StatelessWidget {
  final String imagePath;
  final double top;
  final double left;
  final double width;
  final double height;

  ImageTile({
    required this.imagePath,
    required this.top,
    required this.left,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: FileImage(File(imagePath)),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.topRight,
          child: Image.asset(
            'assets/images/safteypingreen.jpg', // Nail image
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}
