import 'dart:io';

import 'package:chat/models/chat_user.dart';
import 'package:chat/services/auth/auth_mock_service.dart';

enum AuthServiceType { mock }

abstract class AuthService {
  ChatUser? get currentUser;
  Stream<ChatUser?> get userChanges;

  Future<void> signUp(String name, String email, String password, File? image);
  Future<void> login(String email, String password);
  Future<void> logout();

  factory AuthService(AuthServiceType type) {
    switch (type) {
      case AuthServiceType.mock:
        return AuthMockService();
    }
  }
}
