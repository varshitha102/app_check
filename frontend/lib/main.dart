import 'package:flutter/material.dart';
import 'screens/register_screen.dart';

void main() {
  runApp(const AuthPrototypeApp());
}

class AuthPrototypeApp extends StatelessWidget {
  const AuthPrototypeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth Prototype',
      debugShowCheckedModeBanner: false,
      home: const RegisterScreen(),
    );
  }
}
