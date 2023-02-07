import 'package:chat_app/screens/auth_screen.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark),
    );
    return MaterialApp(
        title: Constants.appTitle,
        theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: Colors.blueAccent,
            secondary: Colors.orange,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const ChatScreen());
  }
}
