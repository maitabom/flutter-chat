import 'dart:io';

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

  Widget _showUserAvatar(String imageUrl) {
    ImageProvider? provider;
    final uri = Uri.parse(imageUrl);
    final assetImage = 'assets/avatar.png';

    if (uri.path.contains(assetImage)) {
      provider = AssetImage(assetImage);
    } else if (uri.scheme.contains('http')) {
      provider = NetworkImage(uri.toString());
    } else {
      provider = FileImage(File(uri.toString()));
    }

    return CircleAvatar(backgroundImage: provider);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: fromCurrentUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: fromCurrentUser
                    ? Colors.grey.shade300
                    : Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: fromCurrentUser
                      ? Radius.circular(12)
                      : Radius.zero,
                  bottomRight: fromCurrentUser
                      ? Radius.zero
                      : Radius.circular(12),
                ),
              ),
              width: 180,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
              child: Column(
                crossAxisAlignment: fromCurrentUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
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
                    textAlign: fromCurrentUser
                        ? TextAlign.right
                        : TextAlign.left,
                    style: TextStyle(
                      color: fromCurrentUser ? Colors.black : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: fromCurrentUser ? null : 165,
          right: fromCurrentUser ? 165 : null,
          child: _showUserAvatar(message.userImagemUrl),
        ),
      ],
    );
  }
}
