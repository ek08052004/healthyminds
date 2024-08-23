import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'sign_up_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Simulate a network call or async operation to check authentication status
    Future.delayed(Duration(seconds: 0), () async {
      // Replace this with your actual authentication logic
      bool isLoggedIn = await checkIfLoggedIn();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            final pageController = PageController(initialPage: 0);
            return isLoggedIn
                ? HomeScreen()
                : LoginScreen(controller: pageController);
          },
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
    await Future.delayed(Duration(seconds: 0));
    // Return true or false based on actual authentication status
    return false; // Replace with actual condition
  }
}
