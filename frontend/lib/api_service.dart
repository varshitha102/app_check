import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // IMPORTANT: set this to your Render URL
  static const String baseUrl = "https://your-render-url.onrender.com";

  static Future<void> register({
    required String username,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse("$baseUrl/register");
    final res = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "email": email,
        "password": password,
      }),
    );

    if (res.statusCode != 200) {
      throw Exception(_extractError(res.body));
    }
  }

  static Future<String> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse("$baseUrl/login");
    final res = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    if (res.statusCode != 200) {
      throw Exception(_extractError(res.body));
    }

    final data = jsonDecode(res.body);
    return data["access_token"];
  }

  static Future<Map<String, dynamic>> me(String token) async {
    final url = Uri.parse("$baseUrl/me");
    final res = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );

    if (res.statusCode != 200) {
      throw Exception(_extractError(res.body));
    }

    return jsonDecode(res.body) as Map<String, dynamic>;
  }

  static String _extractError(String body) {
    try {
      final decoded = jsonDecode(body);
      if (decoded is Map && decoded["detail"] != null) return decoded["detail"].toString();
      return body;
    } catch (_) {
      return body;
    }
  }
}
