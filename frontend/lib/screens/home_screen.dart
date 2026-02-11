import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api_service.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<Map<String, dynamic>> _loadMe() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("jwt_token");
    if (token == null || token.isEmpty) {
      throw Exception("Missing token. Please login again.");
    }
    return ApiService.me(token);
  }

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("jwt_token");
    if (!context.mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          TextButton(
            onPressed: () => _logout(context),
            child: const Text("Logout", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: _loadMe(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading...");
            }
            if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Text("Error: ${snapshot.error}"),
              );
            }
            final data = snapshot.data!;
            final username = data["username"] ?? "user";
            return Text("Welcome $username");
          },
        ),
      ),
    );
  }
}
