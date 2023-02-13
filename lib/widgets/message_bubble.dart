import 'package:chat_app/utils/dimen.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.isCurrentUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment:
          isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isCurrentUser ? Colors.grey.shade300 : colorScheme.secondary,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(Dimen.bubbleBorderRadius),
              topRight: const Radius.circular(Dimen.bubbleBorderRadius),
              bottomLeft: isCurrentUser
                  ? const Radius.circular(Dimen.bubbleBorderRadius)
                  : const Radius.circular(0),
              bottomRight: isCurrentUser
                  ? const Radius.circular(0)
                  : const Radius.circular(Dimen.bubbleBorderRadius),
            ),
          ),
          width: MediaQuery.of(context).size.width * 0.45,
          padding: const EdgeInsets.symmetric(
            vertical: Dimen.bubblePaddingVertical,
            horizontal: Dimen.bubblePaddingHorizontal,
          ),
          margin: const EdgeInsets.symmetric(
            vertical: Dimen.bubbleMarginVertical,
            horizontal: Dimen.bubbleMarginHorizontal,
          ),
          child: Text(
            message,
            style: TextStyle(
                color: isCurrentUser ? Colors.black : colorScheme.onSecondary),
          ),
        ),
      ],
    );
  }
}
