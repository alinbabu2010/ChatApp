import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/constants.dart';

class FireStoreManager {

  static FireStoreManager? _manager;
  late FirebaseFirestore _fireStore;

  FireStoreManager() {
    _fireStore = FirebaseFirestore.instance;
  }

  static FireStoreManager get instance => _manager ?? FireStoreManager();

  Future<void> setUserName(String username, String email, String uid) {
    final data = {
      Constants.fieldUsername: username,
      Constants.fieldEmail: email
    };
    return _fireStore.collection(Constants.collectionUsers).doc(uid).set(data);
  }

  void sendMessage(String message) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    _fireStore.collection(Constants.collectionChat).add({
      Constants.fieldText: message,
      Constants.fieldCreatedAt: Timestamp.now(),
      Constants.fieldUserId: userId
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatMessages() {
    return _fireStore
        .collection(Constants.collectionChat)
        .orderBy(Constants.fieldCreatedAt, descending: true)
        .snapshots();
  }

}