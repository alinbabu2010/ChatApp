import 'package:chat_app/utils/response.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthManager {
  static AuthManager? _authManager;
  late final FirebaseAuth _auth;

  AuthManager() {
    _auth = FirebaseAuth.instance;
  }

  static AuthManager get instance => _authManager ??= AuthManager();

  Future<Response<UserCredential>> signIn(String email, String password) async {
    function() =>
        _auth.signInWithEmailAndPassword(email: email, password: password);
    return await _handle<UserCredential>(function);
  }

  Future<Response<UserCredential>> signup(String email, String password) async {
    function() =>
        _auth.createUserWithEmailAndPassword(email: email, password: password);
    return await _handle<UserCredential>(function);
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
}
