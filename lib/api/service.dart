import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/auth_utils.dart';

class ApiService {
  final String baseUrl = 'http://10.0.2.2:5000'; // Update with your server's URL

  Future<bool> signUp({
    required String name,
    required String username,
    required String email,
    required String password,
    String? phone,
    String? pic,
  }) async {
    var url = Uri.parse('$baseUrl/api/user');
    
    var body = {
      'name': name,
      'username': username,
      'email': email,
      'password': password,
      if (phone != null) 'phone': phone,
      if (pic != null) 'pic': pic,
    };

    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to sign up: ${response.body}');
    }
  }

  Future<bool> login({required String email, required String password}) async {
    var url = Uri.parse('$baseUrl/api/user/login');
    var response = await http.post(
      url,
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      // Parse the response body to get the token
      var responseData = jsonDecode(response.body);
      var token = responseData['token'];

      // Store the token securely
      await AuthUtils.storeAuthToken(token);

      return true;
    } else {
      throw Exception('Failed to log in: ${response.body}');
    }
  }

  Future<http.Response> get(String endpoint) async {
    final token = await AuthUtils.getAuthToken();

    if (token == null) {
      throw Exception('No authentication token found.');
    }

    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }

  Future<http.Response> post(String endpoint, {required Map<String, dynamic> body}) async {
    final token = await AuthUtils.getAuthToken();

    if (token == null) {
      throw Exception('No authentication token found.');
    }

    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    return response;
  }
}


