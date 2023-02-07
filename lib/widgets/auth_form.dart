import 'package:chat_app/utils/constants.dart';
import 'package:chat_app/utils/dimen.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(Dimen.authFormCardMargin),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Dimen.authFormCardPadding),
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: Constants.emailAddress,
                      hintText: Constants.emailHint,
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: Constants.username,
                      hintText: Constants.usernameHint,
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: Constants.password,
                      hintText: Constants.passwordHint,
                    ),
                    obscureText: true,
                    obscuringCharacter: Constants.obscuringCharacter,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: Dimen.authFormBoxHeight),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(Constants.login),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(Constants.createAccount),
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
