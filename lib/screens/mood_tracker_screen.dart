import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

class MoodTrackerScreen extends StatefulWidget {
  @override
  _MoodTrackerScreenState createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen> {
  int _selectedMood = 4; // Default to Awful
  DateTime _selectedDay = DateTime.now();

  final List<String> moods = ["Rad", "Good", "Meh", "Bad", "Awful"];
  final List<IconData> moodIcons = [
    Icons.sentiment_very_satisfied,
    Icons.sentiment_satisfied,
    Icons.sentiment_neutral,
    Icons.sentiment_dissatisfied,
    Icons.sentiment_very_dissatisfied
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
                        fontSize: 24,
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
                      "MOOD GRAPH",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 300, // Adjust height as needed
                      child: MoodGraph(moodData: moodData, moodColors: moodColors, moodIcons: moodIcons),
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
    final double total = moodCounts.reduce((a, b) => a + b).toDouble();
    final double radius = min(size.width / 2, size.height / 2);
    final Paint paint = Paint()
      ..style = PaintingStyle.fill;

    double startAngle = 0.0;
    for (int i = 0; i < moodCounts.length; i++) {
      final double sweepAngle = (moodCounts[i] / total) * 2 * pi;
      paint.color = moodColors[i];
      canvas.drawArc(
        Rect.fromLTWH(0, 0, size.width, size.height),
        startAngle,
        sweepAngle,
        true,
        paint,
      );
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class MoodGraph extends StatelessWidget {
  final Map<DateTime, int> moodData;
  final List<Color> moodColors;
  final List<IconData> moodIcons;

  MoodGraph({required this.moodData, required this.moodColors, required this.moodIcons});

  @override
  Widget build(BuildContext context) {
    List<FlSpot> spots = [];
    List<DateTime> dates = moodData.keys.toList();
    dates.sort();
    for (int i = 0; i < dates.length; i++) {
      DateTime date = dates[i];
      int moodIndex = moodData[date]!;
      double moodValue = 0;

      if (moodIndex == 0) { // Rad
        moodValue = 4.0; // Highest point
      } else if (moodIndex == 1) { // Good
        moodValue = 3.0; // High point
      } else if (moodIndex == 2) { // Meh
        moodValue = 2.0; // Middle point
      } else if (moodIndex == 3) { // Bad
        moodValue = 1.0; // Low point
      } else if (moodIndex == 4) { // Awful
        moodValue = 0.0; // Lowest point
      }

      spots.add(
        FlSpot(i.toDouble(), moodValue),
      );
    }

    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                DateTime date = dates[value.toInt()];
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      DateFormat('MM/dd').format(date),
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                int moodIndex = 4 - value.toInt(); // Reverse the order
                if (moodIndex < 0 || moodIndex >= moodIcons.length) return Container();
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Icon(
                      moodIcons[moodIndex],
                      color: moodColors[moodIndex],
                      size: 20,
                    ),
                  ),
                );
              },
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            gradient: LinearGradient(
              colors: [
                Colors.yellow, // Rad
                Colors.green,  // Good
                Colors.purple, // Meh
                Colors.orange, // Bad
                Colors.red,    // Awful
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            belowBarData: BarAreaData(show: false),
          ),
        ],
        minX: 0,
        maxX: (dates.length - 1).toDouble(),
        minY: 0,
        maxY: 4, // Corresponds to Rad
        lineTouchData: LineTouchData(enabled: false),
        extraLinesData: ExtraLinesData(
          extraLinesOnTop: false,
          horizontalLines: [
            HorizontalLine(
              y: 2, // Center line for Meh mood
              color: Colors.black,
              dashArray: [5, 5],
              label: HorizontalLineLabel(
                show: true,
                labelResolver: (line) => "Meh",
                alignment: Alignment.bottomRight,
                style: TextStyle(color: Colors.purple),
              ),
            ),
          ],
        ),
      ),
    );
  }
}