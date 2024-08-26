import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Define the Habit class
class Habit {
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  int completionCount;

  Habit({
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    this.completionCount = 0,
  });
}

class AddHabitScreen extends StatefulWidget {
  @override
  _AddHabitScreenState createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  IconData _selectedIcon = Icons.star;
  Color _selectedColor = Colors.orange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[900],
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('New Habit',
            style: GoogleFonts.chakraPetch(
              textStyle: TextStyle(color: Colors.white),
            )),
        actions: [
          IconButton(
            icon: Icon(Icons.check, color: Colors.white),
            onPressed: () {
              // Validate if the name field is not empty
              if (_nameController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Please enter a habit name.',
                      style: GoogleFonts.chakraPetch(),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              // Create new habit instance
              final newHabit = Habit(
                name: _nameController.text.trim(),
                description: _descriptionController.text.trim(),
                icon: _selectedIcon,
                color: _selectedColor,
                completionCount: 0, // Initialize completion count
              );

              // Pass the created habit back to the previous screen
              Navigator.pop(context, newHabit);
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.deepPurple[900],
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField('Name', _nameController),
              SizedBox(height: 16),
              _buildTextField('Description', _descriptionController),
              SizedBox(height: 24),
              _buildIconSelection(),
              SizedBox(height: 16),
              _buildColorSelection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hint,
            style: GoogleFonts.chakraPetch(
              textStyle: TextStyle(color: Colors.white),
            )),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          style: GoogleFonts.chakraPetch(
            textStyle: TextStyle(color: Colors.white),
          ),
          decoration: InputDecoration(
            fillColor: Colors.deepPurple[300],
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIconSelection() {
    List<IconData> icons = [
      Icons.favorite,
      Icons.alarm,
      Icons.apple,
      Icons.bed,
      Icons.book,
      Icons.brush,
      Icons.camera,
      Icons.directions_bike,
      Icons.fitness_center,
      Icons.local_cafe,
      Icons.music_note,
      Icons.spa,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Icon',
            style: GoogleFonts.chakraPetch(
              textStyle: TextStyle(color: Colors.white),
            )),
        SizedBox(height: 8),
        Wrap(
          spacing: 10,
          children: icons.map((icon) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIcon = icon;
                });
              },
              child: CircleAvatar(
                backgroundColor: _selectedIcon == icon
                    ? Colors.deepPurple[300]
                    : Colors.deepPurple[800],
                child: Icon(icon, color: Colors.white),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildColorSelection() {
    List<Color> colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.pink,
      Colors.teal,
      Colors.amber,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Color',
            style: GoogleFonts.chakraPetch(
              textStyle: TextStyle(color: Colors.white),
            )),
        SizedBox(height: 8),
        Wrap(
          spacing: 10,
          children: colors.map((color) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = color;
                });
              },
              child: CircleAvatar(
                backgroundColor: color,
                child: _selectedColor == color
                    ? Icon(Icons.check, color: Colors.white)
                    : null,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
