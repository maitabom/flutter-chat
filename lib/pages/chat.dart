import 'package:chat/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService(AuthServiceType.mock);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Chat Page'),
            TextButton(
              onPressed: () {
                authService.logout();
              },
              child: Text('Sair'),
            ),
          ],
        ),
      ),
    );
  }
}
