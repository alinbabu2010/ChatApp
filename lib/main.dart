import 'package:chat_app/screens/auth_screen.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:chat_app/utils/dimen.dart';
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
      SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.pinkAccent.shade100,
          systemNavigationBarIconBrightness: Brightness.light),
    );
    return MaterialApp(
      title: Constants.appTitle,
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.pinkAccent,
          secondary: Colors.deepPurpleAccent,
          background: Colors.pinkAccent,
          brightness: Brightness.dark,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            padding: const MaterialStatePropertyAll(
              EdgeInsets.symmetric(horizontal: Dimen.buttonHorizontalPadding),
            ),
            backgroundColor: const MaterialStatePropertyAll(Colors.pink),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimen.buttonBorderRadius))),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.pink,
          foregroundColor: Colors.limeAccent,
          actionsIconTheme: IconThemeData(
            color: Colors.deepPurple
          ),
          iconTheme: IconThemeData(
            color: Colors.amberAccent
          )
        )
      ),
      debugShowCheckedModeBanner: false,
      home: const AuthScreen(),
    );
  }
}
