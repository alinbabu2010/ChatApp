import 'dart:io';

import 'package:chat_app/managers/validation_manager.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:chat_app/utils/dimen.dart';
import 'package:chat_app/widgets/auth/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(
    String email,
    String password,
    String username,
    File? userImage,
    bool isLogin,
  ) onSubmit;

  final bool isLoading;

  const AuthForm(this.onSubmit, this.isLoading, {Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final validationManager = ValidationManager.instance;

  var _isLogin = true;

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  String _userEmail = "";
  String _userPassword = "";
  String _username = "";
  File? _userImage;

  void _pickedImage(File image) {
    _userImage = image;
  }

  void _trySubmit() {
    final isValidForm = _formKey.currentState?.validate() ?? false;
    FocusScope.of(context).unfocus(); // Remove focus from all input fields

    if (_userImage == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(Constants.imagePickError),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
      return;
    }

    if (isValidForm) {
      _formKey.currentState?.save();
      widget.onSubmit(_userEmail, _userPassword, _username, _userImage,_isLogin);
    }
  }

  void _switchMode() {
    setState(() {
      _isLogin = !_isLogin;
      if (_isLogin) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
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
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    child: SizedBox(
                      height: _isLogin ? 0 : null,
                      child: UserImagePicker(imagePickerCallback: _pickedImage),
                    ),
                  ),
                  TextFormField(
                    key: const ValueKey(Constants.emailAddress),
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: Constants.emailAddress,
                      hintText: Constants.emailHint,
                    ),
                    textInputAction: TextInputAction.next,
                    validator: validationManager.isValidEmail,
                    onSaved: (value) => _userEmail = value?.trim() ?? "",
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    child: SizedBox(
                      height: _isLogin ? 0 : null,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: _isLogin
                            ? const SizedBox()
                            : TextFormField(
                                key: const ValueKey(Constants.username),
                                decoration: const InputDecoration(
                                  labelText: Constants.username,
                                  hintText: Constants.usernameHint,
                                ),
                                textInputAction: TextInputAction.next,
                                validator: validationManager.isValidUsername,
                                onSaved: (value) => _username = value ?? "",
                              ),
                      ),
                    ),
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
                  if (widget.isLoading)
                    const CircularProgressIndicator()
                  else
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: _trySubmit,
                          child: Text(
                              _isLogin ? Constants.login : Constants.signup),
                        ),
                        TextButton(
                          onPressed: _switchMode,
                          child: Text(_isLogin
                              ? Constants.createAccount
                              : Constants.haveUserAccount),
                        )
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
