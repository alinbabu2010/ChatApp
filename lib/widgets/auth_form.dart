import 'package:chat_app/managers/validation_manager.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:chat_app/utils/dimen.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final validationManager = ValidationManager.instance;

  var _isLogin = true;

  String _userEmail = "";
  String _userPassword = "";
  String _username = "";

  void _trySubmit() {
    final isValidForm = _formKey.currentState?.validate() ?? false;
    FocusScope.of(context).unfocus(); // Remove focus from all input fields
    if (isValidForm) {
      _formKey.currentState?.save();
      print("$_username - $_userEmail - $_userPassword");
    }
  }

  void _switchMode() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(Dimen.authFormCardMargin),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Dimen.authFormCardPadding),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: const ValueKey(Constants.emailAddress),
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: Constants.emailAddress,
                      hintText: Constants.emailHint,
                    ),
                    textInputAction: TextInputAction.next,
                    validator: validationManager.isValidEmail,
                    onSaved: (value) => _userEmail = value ?? "",
                  ),
                  if(!_isLogin)
                  TextFormField(
                    key: const ValueKey(Constants.username),
                    decoration: const InputDecoration(
                      labelText: Constants.username,
                      hintText: Constants.usernameHint,
                    ),
                    textInputAction: TextInputAction.next,
                    validator: validationManager.isValidUsername,
                    onSaved: (value) => _username = value ?? "",
                  ),
                  TextFormField(
                    key: const ValueKey(Constants.password),
                    decoration: const InputDecoration(
                      labelText: Constants.password,
                      hintText: Constants.passwordHint,
                    ),
                    obscureText: true,
                    obscuringCharacter: Constants.obscuringCharacter,
                    textInputAction: TextInputAction.next,
                    validator: validationManager.isValidPassword,
                    onSaved: (value) => _userPassword = value ?? "",
                  ),
                  const SizedBox(height: Dimen.authFormBoxHeight),
                  ElevatedButton(
                    onPressed: _trySubmit,
                    child: Text(_isLogin ? Constants.login : Constants.signup),
                  ),
                  TextButton(
                    onPressed: _switchMode,
                    child: Text(_isLogin
                        ? Constants.createAccount
                        : Constants.haveUserAccount),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
