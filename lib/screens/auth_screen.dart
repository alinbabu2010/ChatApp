import 'dart:io';

import 'package:chat_app/managers/auth_manager.dart';
import 'package:chat_app/widgets/auth/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/response.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = AuthManager.instance;

  var _isLoading = false;

  void _setLoadingIndicator(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  Future<void> _submitAuthFrom(
    String email,
    String password,
    String username,
    File? userImage,
    bool isLogin,
  ) async {
    Response<UserCredential> response;

    _setLoadingIndicator(true);

    if (isLogin) {
      response = await _auth.signIn(email, password);
    } else {
      response = await _auth.signup(username, email, password, userImage!);
    }

    _setLoadingIndicator(false);

    if (response.isSuccess) {
      //print(response.data?.user);
    } else {
      handleError(response.message);
    }
  }

  void handleError(String? message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message?.isEmpty == true
            ? Constants.catchErrorMsg
            : message ?? Constants.catchErrorMsg,
        style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
      ),
      backgroundColor: Colors.red,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: AuthForm(_submitAuthFrom, _isLoading),
    );
  }
}
