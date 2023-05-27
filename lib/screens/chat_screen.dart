import 'package:chat_app/managers/auth_manager.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:chat_app/widgets/chat/messages.dart';
import 'package:chat_app/widgets/chat/new_messages.dart';
import 'package:chat_app/widgets/helper/batter_stats.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../utils/notification_initilizers.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Future<void> requestNotificationPermission() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  @override
  void initState() {
    super.initState();
    requestNotificationPermission();
    // Set the background messaging handler early on, as a named top-level function
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      setupFlutterNotifications();
      showFlutterNotification(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.chat),
        actions: [
          /// Added [DropdownButton] to explore it preferred using [PopMenuButton] instead
          DropdownButton(
              alignment: Alignment.center,
              underline: const SizedBox(),
              items: const [
                DropdownMenuItem(
                  value: Constants.logoutKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [Icon(Icons.exit_to_app), Text(Constants.logout)],
                  ),
                )
              ],
              onChanged: (id) {
                if (id == Constants.logoutKey) AuthManager.instance.signOut();
              },
              icon: const Icon(Icons.more_vert))
        ],
      ),
      body: const SizedBox(
        child: Column(
          children: [
            Expanded(child: Messages()),
            NewMessage(),
            BatteryStatus(),
          ],
        ),
      ),
    );
  }
}
