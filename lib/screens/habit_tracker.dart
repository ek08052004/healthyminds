import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_habit.dart'; // Import the AddHabitScreen

class Habit {
  String name;
  String description;
  IconData icon;
  Color color;
  int completionCount;
  final int totalSquares;

  Habit({
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    this.completionCount = 0,
    this.totalSquares = 7, // Number of squares to represent progress
  });
}

class HabitTrackerScreen extends StatefulWidget {
  @override
  _HabitTrackerScreenState createState() => _HabitTrackerScreenState();
}

class _HabitTrackerScreenState extends State<HabitTrackerScreen> {
  List<Habit> _habits = []; // List to store habits

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[900], // Dark purple background color
      appBar: AppBar(
        title: Text(
          'Habit Tracker',
          style: GoogleFonts.chakraPetch(
            textStyle: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor:
            Colors.deepPurple[800], // App bar with dark purple color
      ),
      body: Center(
        child: _habits.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_circle_outline,
                    size: 100,
                    color: Colors.deepPurple[300],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No Habit Found',
                    style: GoogleFonts.chakraPetch(
                      textStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.deepPurple[300], // Button color light purple
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () async {
                      // Navigate to add habit screen and await result
                      final newHabit = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddHabitScreen(),
                        ),
                      );

                      // If a new habit was created, add it to the list
                      if (newHabit != null) {
                        setState(() {
                          _habits.add(newHabit);
                        });
                      }
                    },
                    child: Text(
                      'Add a New Habit',
                      style: GoogleFonts.chakraPetch(
                        textStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : ListView.builder(
                itemCount: _habits.length,
                itemBuilder: (context, index) {
                  return HabitTile(
                    habit: _habits[index],
                    onUpdate: () => setState(() {}),
                  );
                },
              ),
      ),
    );
  }
}

class HabitTile extends StatelessWidget {
  final Habit habit;
  final VoidCallback onUpdate;

  HabitTile({required this.habit, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: Colors.deepPurple[800], // Dark purple card color
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(habit.icon, color: habit.color),
                SizedBox(width: 8),
                Text(
                  habit.name,
                  style: GoogleFonts.chakraPetch(
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              habit.description,
              style: GoogleFonts.chakraPetch(
                textStyle: TextStyle(fontSize: 14, color: Colors.white70),
              ),
            ),
            SizedBox(height: 12),
            TrackerGrid(habit: habit, onUpdate: onUpdate),
          ],
        ),
      ),
    );
  }
}

class TrackerGrid extends StatelessWidget {
  final Habit habit;
  final VoidCallback onUpdate;

  TrackerGrid({required this.habit, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(habit.totalSquares, (index) {
        bool isFilled = index < habit.completionCount;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: GestureDetector(
            onTap: () {
              if (habit.completionCount == index) {
                habit.completionCount++;
              } else if (habit.completionCount - 1 == index) {
                habit.completionCount--;
              }
              onUpdate();
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isFilled ? habit.color : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: habit.color),
              ),
              child: Center(
                child: isFilled ? Icon(Icons.check, color: Colors.white) : null,
              ),
            ),
          ),
        );
      }),
    );
  }
}
