import 'package:chat/models/chat_message.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool fromCurrentUser;

  const MessageBubble({
    required this.message,
    required this.fromCurrentUser,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: fromCurrentUser
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: fromCurrentUser
                ? Colors.grey.shade300
                : Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          width: 180,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Column(
            children: [
              Text(
                message.userName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: fromCurrentUser ? Colors.black : Colors.white,
                ),
              ),
              Text(
                message.text,
                style: TextStyle(
                  color: fromCurrentUser ? Colors.black : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
