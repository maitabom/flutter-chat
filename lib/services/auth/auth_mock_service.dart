import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:chat/models/chat_user.dart';
import 'package:chat/services/auth/auth_service.dart';

class AuthMockService implements AuthService {
  static ChatUser? _currentUser;
  static MultiStreamController<ChatUser?>? _controller;

  static final Map<String, ChatUser> _users = {};

  static final _userStream = Stream<ChatUser?>.multi((controller) {
    _controller = controller;
    _updateUser(null);
  });

  @override
  ChatUser? get currentUser {
    return _currentUser;
  }

  @override
  Stream<ChatUser?> get userChanges {
    return _userStream;
  }

  @override
  Future<void> login(String email, String password) async {
    _updateUser(_users[email]);
  }

  @override
  Future<void> logout() async {
    _updateUser(null);
  }

  @override
  Future<void> signUp(
    String name,
    String email,
    String password,
    File? image,
  ) async {
    final newUser = ChatUser(
      id: Random().nextDouble().toString(),
      name: name,
      email: email,
      imageUrl: image?.path ?? '',
    );

    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }

  static void _updateUser(ChatUser? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }
}
