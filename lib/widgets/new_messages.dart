import 'package:chat_app/managers/firestore_manager.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:chat_app/utils/dimen.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  var _enteredMessage = "";

  void _setMessage(String value) {
    setState(() {
      _enteredMessage = value.trim();
    });
  }

  void _sendMessage() {
    _controller.clear();
    FocusScope.of(context).unfocus();
    FireStoreManager.instance.sendMessage(_enteredMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Dimen.msgContainerTopMargin),
      padding: const EdgeInsets.all(Dimen.msgContainerPadding),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: Constants.labelSendMessage,
              ),
              onChanged: _setMessage,
              onTapOutside: (_) {
                FocusScope.of(context).unfocus();
              },
              textInputAction: TextInputAction.done,
              onEditingComplete: _sendMessage,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            color: Theme.of(context).colorScheme.primary,
            onPressed: _enteredMessage.isEmpty ? null : _sendMessage,
          )
        ],
      ),
    );
  }
}
