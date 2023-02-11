import 'package:chat_app/managers/auth_manager.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:chat_app/utils/dimen.dart';
import 'package:chat_app/widgets/progress_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const collectionPath = "chats/msyeLLZyurSquPUK5HNq/messages";
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
                    children: const [Icon(Icons.exit_to_app), Text(Constants.logout)],
                  ),
                )
              ],
              onChanged: (id) {
                if (id == Constants.logoutKey) AuthManager.instance.signOut();
              },
              icon: const Icon(Icons.more_vert))
        ],
      ),
      body: StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ProgressBar();
          }
          final documents = snapshot.data?.docs;
          return ListView.builder(
            itemCount: documents?.length,
            itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.all(Dimen.chatListItemPadding),
              child: Text(documents?.elementAt(index)['text']),
            ),
          );
        },
        stream: FirebaseFirestore.instance.collection(collectionPath).snapshots(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection(collectionPath)
              .add({'text': "This was added by clicking the button!"});
        },
      ),
    );
  }
}
