import 'package:chat_app/utils/constants.dart';
import 'package:chat_app/utils/response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthManager {
  static AuthManager? _authManager;
  late final FirebaseAuth _auth;

  AuthManager() {
    _auth = FirebaseAuth.instance;
  }

  static AuthManager get instance => _authManager ??= AuthManager();

  Stream<User?> get authState => _auth.authStateChanges();

  Future<Response<UserCredential>> signIn(String email, String password) async {
    function() =>
        _auth.signInWithEmailAndPassword(email: email, password: password);
    return await _handle<UserCredential>(function);
  }

  Future<Response<UserCredential>> signup(
      String username, String email, String password) async {
    function() =>
        _auth.createUserWithEmailAndPassword(email: email, password: password);
    final response = await _handle<UserCredential>(function);
    if (response.isError) {
      return response;
    } else {
      final data = {
        Constants.fieldUsername: username,
        Constants.fieldEmail: email
      };
      function() => FirebaseFirestore.instance
          .collection(Constants.collectionUsers)
          .doc(response.data?.user?.uid)
          .set(data);
      final dbResponse = await _handle(function);
      if (dbResponse.isSuccess) {
        return response;
      } else {
        return Response<UserCredential>(message: dbResponse.message);
      }
    }
  }

  Future<Response<T>> _handle<T>(Function request) async {
    try {
      final response = await request();
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
