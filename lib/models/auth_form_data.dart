import 'dart:io';

import 'package:chat/models/auth_mode.dart';

class AuthFormData {
  String name = '';
  String email = '';
  String password = '';
  File? image;

  AuthMode _mode = AuthMode.login;

  bool get isLogin {
    return _mode == AuthMode.login;
  }

  bool get isSignUp {
    return _mode == AuthMode.signup;
  }

  void toggleMode() {
    _mode = isLogin ? AuthMode.signup : AuthMode.login;
  }
}
