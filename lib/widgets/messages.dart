import 'package:chat_app/managers/auth_manager.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:chat_app/widgets/message_bubble.dart';
import 'package:chat_app/widgets/progress_bar.dart';
import 'package:flutter/material.dart';

import '../managers/firestore_manager.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FireStoreManager.instance.getChatMessages(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ProgressBar();
        }
        final chatDocs = snapshot.data?.docs;
        return ListView.builder(
          reverse: true,
          itemCount: chatDocs?.length,
          itemBuilder: (context, index) {
            final chatDoc = chatDocs?.elementAt(index);
            return MessageBubble(
              message: chatDoc?.get(Constants.fieldText),
              isCurrentUser: AuthManager.instance.isCurrentUser(
                chatDoc?.get(Constants.fieldUserId),
              ),
              key: ValueKey(chatDoc?.id),
              username: chatDoc?.get(Constants.fieldUsername),
            );
          },
        );
      },
    );
  }
}
