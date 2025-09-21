import 'dart:io';

import 'package:chat/components/user_image_picker.dart';
import 'package:chat/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;

  const AuthForm({required this.onSubmit, super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _authFormData = AuthFormData();

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    if (_authFormData.image == null && _authFormData.isSignUp) {
      return _showError('Imagem não selecionada.');
    }

    widget.onSubmit(_authFormData);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  void _handleImagePick(File image) {
    _authFormData.image = image;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_authFormData.isSignUp)
                UserImagePicker(onImagePick: _handleImagePick),
              if (_authFormData.isSignUp)
                TextFormField(
                  key: ValueKey('name'),
                  initialValue: _authFormData.name,
                  decoration: InputDecoration(labelText: 'Nome'),
                  onChanged: (name) => _authFormData.name = name,
                  validator: (name) {
                    final pivot = name ?? '';

                    if (pivot.trim().length < 5) {
                      return 'Nome deve ter ao menos 5 caracteres';
                    }

                    return null;
                  },
                ),
              TextFormField(
                key: ValueKey('email'),
                initialValue: _authFormData.email,
                decoration: InputDecoration(labelText: 'E-mail'),
                onChanged: (email) => _authFormData.email = email,
                validator: (email) {
                  final pivot = email ?? '';

                  if (!pivot.contains('@')) {
                    return 'O e-mail informado é inválido';
                  }

                  return null;
                },
              ),
              TextFormField(
                key: ValueKey('password'),
                obscureText: true,
                initialValue: _authFormData.password,
                decoration: InputDecoration(labelText: 'Senha'),
                onChanged: (password) => _authFormData.password = password,
                validator: (password) {
                  final pivot = password ?? '';

                  if (pivot.length < 5) {
                    return 'A senha deve ter ao menos 5 caracteres';
                  }

                  return null;
                },
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: _submit,
                child: Text(_authFormData.isLogin ? 'Entrar' : 'Cadastrar'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _authFormData.toggleMode();
                  });
                },
                child: Text(
                  _authFormData.isLogin
                      ? 'Criar uma nova conta'
                      : 'Já possui conta? Efetue login',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
