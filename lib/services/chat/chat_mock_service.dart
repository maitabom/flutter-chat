import 'dart:async';
import 'dart:math';

import 'package:chat/models/chat_message.dart';
import 'package:chat/models/chat_user.dart';
import 'package:chat/services/chat/chat_service.dart';

class ChatMockService implements ChatService {
  static MultiStreamController<List<ChatMessage>>? _controller;

  static final List<ChatMessage> _messages = [
    ChatMessage(
      id: '1',
      text: 'Olá! Bem-vindo ao chat.',
      create: DateTime.now().subtract(Duration(minutes: 5)),
      userId: 'test_user',
      userName: 'Destinatário Teste',
      userImagemUrl: 'assets/avatar.png',
    ),
    ChatMessage(
      id: '2',
      text: 'Oi! Como posso ajudar você hoje?',
      create: DateTime.now().subtract(Duration(minutes: 3)),
      userId: 'default',
      userName: 'Usuário Teste',
      userImagemUrl: 'assets/avatar.png',
    ),
    ChatMessage(
      id: '3',
      text: 'Fique à vontade para perguntar!',
      create: DateTime.now().subtract(Duration(minutes: 1)),
      userId: 'test_user',
      userName: 'Destinatário Teste',
      userImagemUrl: 'hassets/avatar.png',
    ),
  ];

  static final _messageStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    _controller?.add(_messages);
  });

  @override
  Stream<List<ChatMessage>> messagesStream() {
    return _messageStream;
  }

  @override
  Future<ChatMessage> save(String text, ChatUser user) async {
    final newMessage = ChatMessage(
      id: Random().nextDouble().toString(),
      text: text,
      create: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImagemUrl: user.imageUrl,
    );

    _messages.add(newMessage);
    _controller?.add(_messages);

    return newMessage;
  }
}
