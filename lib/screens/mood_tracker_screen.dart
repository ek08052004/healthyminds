import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';  

class MoodTrackerScreen extends StatefulWidget {
  @override
  _MoodTrackerScreenState createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen> {
  int _selectedMood = 4; // Default to Awful
  DateTime _selectedDay = DateTime.now();

  final List<String> moods = ["Rad", "Good", "Meh", "Bad", "Awful"];
  final List<IconData> moodIcons = [
   FontAwesomeIcons.faceSmileBeam,    // Replaced with FontAwesome icon
    FontAwesomeIcons.faceSmile,        // Replaced with FontAwesome icon
    FontAwesomeIcons.faceMeh,          // Replaced with FontAwesome icon
    FontAwesomeIcons.faceFrown,        // Replaced with FontAwesome icon
    FontAwesomeIcons.faceSadTear,    // Replaced with FontAwesome icon
  ];
  final List<Color> moodColors = [
    Colors.yellow,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.red,
  ];

  final List<int> moodCounts = [0, 0, 0, 0, 0];

  final Map<DateTime, int> moodData = {};

  void _updateMood(int index) {
    setState(() {
      if (!moodData.containsKey(_selectedDay)) {
        _selectedMood = index;
        moodCounts[index] += 1;
        moodData[_selectedDay] = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat.yMMMMd().format(DateTime.now());

    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Mood Tracker'),
            Text(
              formattedDate,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "How Do You Feel Today?",
                      style: GoogleFonts.robotoSlab(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                    SizedBox(height: 20),
                    Icon(
                      moodIcons[_selectedMood],
                      color: Colors.yellow[600],
                      size: 100,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(moods.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            _updateMood(index);
                          },
                          child: Column(
                            children: [
                              Icon(
                                moodIcons[index],
                                color: _selectedMood == index
                                    ? Colors.yellow[600]
                                    : Colors.grey,
                                size: 40,
                              ),
                              Text(
                                moods[index],
                                style: TextStyle(
                                  color: _selectedMood == index
                                      ? Colors.yellow[600]
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 20),
                    if (moodData.containsKey(_selectedDay))
                      Text(
                        "Mood for today has already been set!",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "Mood Count",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      "Tap on mood to see more",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomPaint(
                      size: Size(100, 100),
                      painter: MoodPieChartPainter(moodCounts, moodColors),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(moods.length, (index) {
                        return Column(
                          children: [
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Icon(
                                  moodIcons[index],
                                  color: Colors.grey,
                                  size: 40,
                                ),
                                if (moodCounts[index] > 0)
                                  CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.orange,
                                    child: Text(
                                      moodCounts[index].toString(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            Text(
                              moods[index],
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "Mood Calendar",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 20),
                    TableCalendar(
                      focusedDay: _selectedDay,
                      firstDay: DateTime.utc(2020, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      calendarStyle: CalendarStyle(
                        markerDecoration: BoxDecoration(
                          color: Colors.purple,
                          shape: BoxShape.circle,
                        ),
                      ),
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        if (selectedDay.isAfter(DateTime.now())) {
                          // Show an error message or simply return
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('You cannot set a mood for a future date.'),
                            ),
                          );
                          return;
                        }
                        setState(() {
                          _selectedDay = selectedDay;
                        });
                      },
                      calendarBuilders: CalendarBuilders(
                        singleMarkerBuilder: (context, date, events) {
                          int? moodIndex = moodData[date];
                          if (moodIndex != null) {
                            return Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: moodColors[moodIndex],
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  moodIcons[moodIndex],
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mood Graph",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 300, // Adjust height as needed
                      child: MoodGraph(
                          moodData: moodData,
                          moodColors: moodColors,
                          moodIcons: moodIcons),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.purple,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[500],
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            label: 'Health',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class MoodPieChartPainter extends CustomPainter {
  final List<int> moodCounts;
  final List<Color> moodColors;

  MoodPieChartPainter(this.moodCounts, this.moodColors);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final total = moodCounts.reduce((a, b) => a + b);
    double startAngle = -pi / 2;

    for (int i = 0; i < moodCounts.length; i++) {
      final sweepAngle = 2 * pi * (moodCounts[i] / total);
      paint.color = moodColors[i];
      canvas.drawArc(
        Rect.fromCenter(
            center: Offset(size.width / 2, size.height / 2),
            width: size.width,
            height: size.height),
        startAngle,
        sweepAngle,
        true,
        paint,
      );
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class MoodGraph extends StatelessWidget {
  final Map<DateTime, int> moodData;
  final List<Color> moodColors;
  final List<IconData> moodIcons;

  MoodGraph(
      {required this.moodData,
      required this.moodColors,
      required this.moodIcons});

  @override
  Widget build(BuildContext context) {
    List<DateTime> sortedDates = moodData.keys.toList()
      ..sort((a, b) => a.compareTo(b));
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 22,
              getTitlesWidget: (value, meta) {
                int index = value.toInt();
                if (index < 0 || index >= sortedDates.length) {
                  return Container();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(DateFormat('MMMd').format(sortedDates[index])),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.black12),
        ),
        minX: 0,
        maxX: sortedDates.length - 1.toDouble(),
        minY: 0,
        maxY: 4,
        lineBarsData: [
          LineChartBarData(
            spots: sortedDates.asMap().entries.map((entry) {
              int index = entry.key;
              DateTime date = entry.value;
              int moodIndex = moodData[date] ?? 0;
              return FlSpot(index.toDouble(), moodIndex.toDouble());
            }).toList(),
            isCurved: true,
            color: Colors.purple,
            barWidth: 4,
            belowBarData: BarAreaData(show: false),
            dotData: FlDotData(show: false),
          ),
        ],
      ),
    );
  }
}
