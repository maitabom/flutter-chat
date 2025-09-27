import 'package:chat/components/message_bubble.dart';
import 'package:chat/models/chat_message.dart';
import 'package:chat/services/auth/auth_service.dart';
import 'package:chat/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final chatService = ChatService(ChatServiceType.mock);
    final authService = AuthService(AuthServiceType.mock);
    final currentUser = authService.currentUser;

    return StreamBuilder<List<ChatMessage>>(
      stream: chatService.messagesStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Nenhuma mensagem'));
        } else {
          final messages = snapshot.data!;

          return ListView.builder(
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];

              return MessageBubble(
                message: message,
                fromCurrentUser: currentUser?.id == message.userId,
                key: ValueKey(message.id),
              );
            },
          );
        }
      },
    );
  }
}
