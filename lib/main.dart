import 'dart:developer';

import 'package:chat_app/managers/auth_manager.dart';
import 'package:chat_app/screens/auth_screen.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:chat_app/utils/dimen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.instance.subscribeToTopic(Constants.chat);
  final token = await FirebaseMessaging.instance.getToken(); 
  log("Token : $token");
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
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.pinkAccent,
          systemNavigationBarIconBrightness: Brightness.light),
    );
    return MaterialApp(
      title: Constants.appTitle,
      theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: Colors.pinkAccent,
            secondary: Colors.deepPurpleAccent,
            background: Colors.pinkAccent,
            brightness: Brightness.light,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              padding: const MaterialStatePropertyAll(
                EdgeInsets.symmetric(horizontal: Dimen.buttonHorizontalPadding),
              ),
              backgroundColor: const MaterialStatePropertyAll(Colors.pink),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(Dimen.buttonBorderRadius))),
            ),
          ),
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.pink,
              foregroundColor: Colors.limeAccent,
              actionsIconTheme: IconThemeData(color: Colors.deepPurple),
              iconTheme: IconThemeData(color: Colors.amberAccent))),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: AuthManager.instance.authState,
        builder: (context, snapshot) =>
            snapshot.hasData ? const ChatScreen() : const AuthScreen(),
      ),
    );
  }
}
