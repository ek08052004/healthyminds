import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Simulate a network call or async operation to check authentication status
    Future.delayed(Duration(seconds: 2), () async {
      // Replace this with your actual authentication logic
      bool isLoggedIn = await checkIfLoggedIn();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => isLoggedIn ? HomeScreen() : LoginScreen(),
        ),
      );
    });

    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // A loading spinner
      ),
    );
  }

  Future<bool> checkIfLoggedIn() async {
    // Simulate a delay for authentication check
    await Future.delayed(Duration(seconds: 1));
    // Return true or false based on actual authentication status
    return false; // Replace with actual condition
  }
}
