import 'package:chat/models/chat_user.dart';
import 'package:chat/pages/auth.dart';
import 'package:chat/pages/chat.dart';
import 'package:chat/pages/loading.dart';
import 'package:chat/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService(AuthServiceType.mock);

    return Scaffold(
      body: StreamBuilder<ChatUser?>(
        stream: authService.userChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingPage();
          } else {
            return snapshot.hasData ? ChatPage() : AuthPage();
          }
        },
      ),
    );
  }
}
