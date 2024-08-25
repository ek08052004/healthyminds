import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthUtils {
  static const String _authTokenKey = 'auth_token';
  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  // Store the token securely
  static Future<void> storeAuthToken(String token) async {
    await _storage.write(key: _authTokenKey, value: token);
  }

  // Retrieve the token securely
  static Future<String?> getAuthToken() async {
    return await _storage.read(key: _authTokenKey);
  }

  // Check if the token is stored
  static Future<bool> isTokenStored() async {
    final token = await getAuthToken();
    return token != null && token.isNotEmpty;
  }

  // Clear the token (e.g., on logout)
  static Future<void> clearAuthToken() async {
    await _storage.delete(key: _authTokenKey);
  }
}
