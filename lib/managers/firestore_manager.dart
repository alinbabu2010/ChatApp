import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../utils/constants.dart';

class FireStoreManager {
  static FireStoreManager? _manager;
  late FirebaseFirestore _fireStore;
  late FirebaseStorage _firebaseStorage;

  FireStoreManager() {
    _fireStore = FirebaseFirestore.instance;
    _firebaseStorage = FirebaseStorage.instance;
  }

  static FireStoreManager get instance => _manager ?? FireStoreManager();

  /// To store user data to Firebase.
  /// Save user data to user collection in FireStore Storage
  /// Store image file to Firebase storage and get a image URL.
  Future<void> storeUserData(
    String username,
    String email,
    String uid,
    File userImage,
  ) async {
    String imageUrl = await _storeImage(uid, userImage);
    final data = {
      Constants.fieldUsername: username,
      Constants.fieldEmail: email,
      Constants.fieldImageUrl: imageUrl
    };
    return _fireStore.collection(Constants.collectionUsers).doc(uid).set(data);
  }

  /// Store image file to Firebase storage and get a image URL.
  Future<String> _storeImage(String uid, File userImage) async {
    final reference = _firebaseStorage
        .ref()
        .child(Constants.childUserImage)
        .child("$uid.jpg");
    await reference.putFile(userImage);
    final imageUrl = await reference.getDownloadURL();
    return imageUrl;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _getUserData(String? userId) {
    return _fireStore.collection(Constants.collectionUsers).doc(userId).get();
  }

  Future<void> sendMessage(String message) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final userData = await _getUserData(userId);
    _fireStore.collection(Constants.collectionChat).add({
      Constants.fieldText: message,
      Constants.fieldCreatedAt: Timestamp.now(),
      Constants.fieldUserId: userId,
      Constants.fieldUsername: userData[Constants.fieldUsername],
      Constants.fieldImageUrl: userData[Constants.fieldImageUrl]
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatMessages() {
    return _fireStore
        .collection(Constants.collectionChat)
        .orderBy(Constants.fieldCreatedAt, descending: true)
        .snapshots();
  }
}
