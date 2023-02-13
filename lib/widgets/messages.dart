import 'package:chat_app/utils/constants.dart';
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
          itemBuilder: (context, index) =>
              Text(chatDocs?.elementAt(index)[Constants.fieldText]),
        );
      },
    );
  }
}
