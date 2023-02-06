import 'package:chat_app/screens/chat_screen.dart';
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
        title: 'Flutter Chat',
        theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: Colors.blueAccent,
            secondary: Colors.orange,
          ),
        ),
        home: const ChatScreen());
  }
}
