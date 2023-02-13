import 'package:cloud_firestore/cloud_firestore.dart';

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
    _fireStore.collection(Constants.collectionChat).add({
      Constants.fieldText: message,
      Constants.fieldCreatedAt: Timestamp.now()
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatMessages() {
    return _fireStore
        .collection(Constants.collectionChat)
        .orderBy(Constants.fieldCreatedAt, descending: true)
        .snapshots();
  }

}