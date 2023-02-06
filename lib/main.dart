import 'package:flutter/material.dart';

void main() {
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
      title: 'Chat App',
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.blueAccent,
          secondary: Colors.orange,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Chat app"),
        ),
        body: const Center(
          child: Text("Sample text....."),
        ),
      ),
    );
  }
}
