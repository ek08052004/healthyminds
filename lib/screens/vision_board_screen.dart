import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';


class VisionBoardScreen extends StatefulWidget {
  @override
  _VisionBoardScreenState createState() => _VisionBoardScreenState();
}

class _VisionBoardScreenState extends State<VisionBoardScreen> {
  final ImagePicker _picker = ImagePicker();
  List<StickyNote> _stickyNotes = [];

  final List<Color> _stickyNoteColors = [
    Colors.yellow[300]!,
    Colors.orange[300]!,
    Colors.pink[300]!,
    Colors.green[300]!,
    Colors.blue[300]!,
    Colors.purple[300]!,
  ];

  Random _random = Random();

  Future<void> _pickImage(StickyNote note) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        note.image = File(image.path);
      });
    }
  }

  void _addStickyNote() {
    setState(() {
      _stickyNotes.add(StickyNote(
        color: _stickyNoteColors[_random.nextInt(_stickyNoteColors.length)],
        position: Offset(
          (MediaQuery.of(context).size.width * 0.5).toDouble(),
          (MediaQuery.of(context).size.height * 0.5).toDouble(),
        ),
      ));
    });
  }

  void _removeStickyNote(StickyNote note) {
    setState(() {
      _stickyNotes.remove(note);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vision Board'),
      ),
      body: Stack(
        children: [
          // Background Color
          Container(
            color: Colors.white,
          ),
          
          // Header Text
              Positioned(
              top: 16,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'MY GOALS',
                  style: GoogleFonts.gloriaHallelujah(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[900],
                  ),
                ),
              ),
            ),

          // Sticky Notes
          ..._stickyNotes.map((note) {
            return Positioned(
              left: note.position.dx,
              top: note.position.dy,
              child: Draggable(
                feedback: _buildStickyNote(note, isDragging: true),
                childWhenDragging: Container(),
                onDragEnd: (details) {
                  setState(() {
                    note.position = details.offset;
                  });
                },
                child: _buildStickyNote(note),
              ),
            );
          }).toList(),

          // Add Sticky Note Button
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: _addStickyNote,
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStickyNote(StickyNote note, {bool isDragging = false}) {
    return GestureDetector(
      onTap: () => _pickImage(note),
      child: Container(
        width: 150, // Increased size of sticky note
        height: 150, // Increased size of sticky note
        decoration: BoxDecoration(
          color: note.color,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
            ),
          ],
        ),
        child: note.image == null
            ? Center(
                child: Icon(Icons.add_photo_alternate, color: Colors.grey[600]),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.file(
                  note.image!,
                  width: 150, // Adjusted size to match the sticky note
                  height: 150, // Adjusted size to match the sticky note
                  fit: BoxFit.cover, // Ensures the image covers the entire sticky note
                ),
              ),
      ),
    );
  }
}

class StickyNote {
  File? image;
  Offset position;
  Color color;

  StickyNote({
    this.image,
    required this.position,
    required this.color,
  });
}
