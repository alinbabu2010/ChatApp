import 'package:chat_app/widgets/progress_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chat').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ProgressBar();
        }
        final chatDocs = snapshot.data?.docs;
        return ListView.builder(
          itemCount: chatDocs?.length,
          itemBuilder: (context, index) =>
              Text(chatDocs?.elementAt(index)['text']),
        );
      },
    );
  }
}
