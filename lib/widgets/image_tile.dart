import 'dart:io';
import 'package:flutter/material.dart';

class ImageTile extends StatelessWidget {
  final String imagePath;

  ImageTile({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          color: Colors.green[200], // Green board color
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.file(
              File(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 2,
          right: 2,
          child: Image.asset(
            'assets/images/safteypingreen.jpg', // Nail image
            width: 24,
            height: 24,
          ),
        ),
      ],
    );
  }
}
