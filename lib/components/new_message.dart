import 'package:chat/services/auth/auth_service.dart';
import 'package:chat/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _enteredMessage = '';

  final _messageController = TextEditingController();

  final authService = AuthService(AuthServiceType.mock);
  final chatService = ChatService(ChatServiceType.mock);

  Future<void> _sendMessage() async {
    final user = authService.currentUser;

    if (user != null) {
      await chatService.save(_enteredMessage, user);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _messageController,
            onChanged: (message) => setState(() {
              _enteredMessage = message;
            }),
            onSubmitted: (_) {
              if (_enteredMessage.trim().isNotEmpty) {
                _sendMessage();
              }
            },
            decoration: InputDecoration(labelText: 'Enviar mensagem'),
          ),
        ),
        IconButton(
          onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          icon: Icon(Icons.send),
        ),
      ],
    );
  }
}
