import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:5000/api/auth';  

  // Sign Up Method
Future<bool> signUp({
  required String name,
  required int age,
  required String username,
  required String email,
  required String phone,
  required String password,
}) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'age': age,
        'username': username,
        'email': email,
        'phone': phone,
        'password': password,
      }),
    );

    // Print raw response body for debugging
    print('Sign Up Response body: ${response.body}');
    print('Status Code: ${response.statusCode}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Handle success
      final data = jsonDecode(response.body);
      print('Decoded data: $data');
      if (data.containsKey('token')) {
        // If token is present, return true
        return true;
      } else {
        // If token is not present, log a message and return false
        print('Sign up successful but token missing in response');
        return false;
      }
    } else {
      // Handle error response
      final responseBody = response.body;
      try {
        final error = jsonDecode(responseBody);
        String message = error['msg'] ?? 'Unknown error occurred';
        print('Failed to sign up: $message');
      } catch (e) {
        // Catch JSON decode errors
        print('Failed to sign up: Response format is invalid. Response: $responseBody');
      }
      return false;
    }
  } catch (e) {
    print('Exception in sign up: $e');
    // Handle any other exceptions
    return false;
  }
}


  // Log In Method
  Future<String> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': email,
          'password': password,
        }),
      );

      // Print raw response body for debugging
      print('Login Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data.containsKey('token')) {
          return data['token'];
        } else {
          throw Exception('Failed to log in: Token not found in response');
        }
      } else {
        // Handle error response
        final responseBody = response.body;
        try {
          final error = jsonDecode(responseBody);
          String message = error['msg'] ?? 'Unknown error occurred';
          throw Exception('Failed to log in: $message');
        } catch (e) {
          // Catch JSON decode errors
          throw Exception('Failed to log in: Response format is invalid. Response: $responseBody');
        }
      }
    } catch (e) {
      print('Exception in login: $e');
      if (e is FormatException) {
        throw Exception('Failed to log in: Response format is invalid');
      }
      throw Exception('Failed to log in: $e');
    }
  }
}
 