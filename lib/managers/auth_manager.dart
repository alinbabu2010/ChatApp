import 'dart:io';

import 'package:chat_app/managers/firestore_manager.dart';
import 'package:chat_app/utils/response.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthManager {
  static AuthManager? _authManager;
  late final FirebaseAuth _auth;
  late final FireStoreManager _fireStoreManager;

  AuthManager() {
    _auth = FirebaseAuth.instance;
    _fireStoreManager = FireStoreManager.instance;
  }

  static AuthManager get instance => _authManager ??= AuthManager();

  Stream<User?> get authState => _auth.authStateChanges();

  bool isCurrentUser(String userId) => _auth.currentUser?.uid == userId;

  Future<Response<UserCredential>> signIn(String email, String password) async {
    final authFuture = _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return await _handle<UserCredential>(authFuture);
  }

  Future<Response<UserCredential>> signup(
    String username,
    String email,
    String password,
    File userImage,
  ) async {
    final authFuture = _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final response = await _handle<UserCredential>(authFuture);
    if (response.isError) {
      return response;
    } else {
      return await _setUsername(username, email, response, userImage);
    }
  }

  Future<Response<UserCredential>> _setUsername(
    String username,
    String email,
    Response<UserCredential> response,
    File userImage,
  ) async {
    final uid = response.data?.user?.uid ?? "";
    final dbResponse = await _handle(
        _fireStoreManager.storeUserData(username, email, uid, userImage));
    if (dbResponse.isSuccess) {
      return response;
    } else {
      return Response<UserCredential>(message: dbResponse.message);
    }
  }

  Future<Response<T>> _handle<T>(Future request) async {
    try {
      final response = await request;
      return Response(data: response);
    } on FirebaseAuthException catch (exception) {
      return Response(message: exception.message);
    } catch (error) {
      return Response(message: error.toString());
    }
  }

  void signOut() {
    _auth.signOut();
  }
}
