import 'dart:io';

import 'package:chat/models/chat_user.dart';
import 'package:chat/services/auth/auth_service.dart';

class AuthMockService implements AuthService {
  @override
  ChatUser? get currentUser {
    return null;
  }

  @override
  Stream<ChatUser?> get userChanges => throw UnimplementedError();

  @override
  Future<void> login(String email, String password) {
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    throw UnimplementedError();
  }

  @override
  Future<void> signUp(String nome, String email, String password, File image) {
    throw UnimplementedError();
  }
}
