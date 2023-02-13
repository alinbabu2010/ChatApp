import 'package:chat_app/managers/auth_manager.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:chat_app/widgets/chat/messages.dart';
import 'package:chat_app/widgets/chat/new_messages.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

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
              items: [
                DropdownMenuItem(
                  value: Constants.logoutKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(Icons.exit_to_app),
                      Text(Constants.logout)
                    ],
                  ),
                )
              ],
              onChanged: (id) {
                if (id == Constants.logoutKey) AuthManager.instance.signOut();
              },
              icon: const Icon(Icons.more_vert))
        ],
      ),
      body: SizedBox(
        child: Column(
          children: const [
            Expanded(child: Messages()),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
