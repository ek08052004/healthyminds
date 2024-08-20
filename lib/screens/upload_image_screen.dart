import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageScreen extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();
  final int imageCount;

  UploadImageScreen({required this.imageCount});

  Future<void> _pickImage(BuildContext context) async {
    if (imageCount < 6) {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        Navigator.pop(context, pickedFile.path);
      } else {
        Navigator.pop(context, null);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('You can only select up to 6 images.'),
      ));
      Navigator.pop(context, null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _pickImage(context),
          child: Text('Select Image from Gallery'),
        ),
      ),
    );
  }
}
