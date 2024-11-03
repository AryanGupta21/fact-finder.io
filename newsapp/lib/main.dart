import 'package:flutter/material.dart';
import 'chat_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FactCheck.io',
      theme: ThemeData(
        primarySwatch: Colors.brown, // Using a neutral color scheme
      ),
      home: const ChatScreen(),
    );
  }
}
