import 'package:flutter/material.dart';
import 'screens/vision_board_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vision Board',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VisionBoardScreen(),
    );
  }
}
