import 'package:flutter/material.dart';

enum AuthMode { Signup, Login }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _passwordController = TextEditingController();
  final _globalKey = GlobalKey<FormState>();
  bool _isLoading = false;

  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {'email': '', 'password': ''};

  void _switchAuthMode() {
    setState(() {
      _authMode = _isLogin() ? AuthMode.Signup : AuthMode.Login;
    });
  }

  void _submit() {
    final isValid = _globalKey.currentState?.validate() ?? false;
    if (!isValid) return;

    setState(() => _isLoading = true);
    _globalKey.currentState?.save();

    if (_isLogin()) {
      print('Logging in with email: ${_authData['email']}');
    } else {
      print('Signing up with email: ${_authData['email']}');
    }

    setState(() => _isLoading = false);
  }

  bool _isLogin() => _authMode == AuthMode.Login;
  bool _isSignup() => _authMode == AuthMode.Signup;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final deviceSize = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(8),
      width: deviceSize.width * 0.75,
      child: Form(
        key: _globalKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Campo de E-mail
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              onSaved: (email) {
                _authData['email'] = email ?? '';
              },
              validator: (_email) {
                final email = _email ?? '';
                if (email.isEmpty || !email.contains('@')) {
                  return 'Informe um e-mail válido!';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),

            // Campo de Senha
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.visibility_off),
              ),
              obscureText: true,
              controller: _passwordController,
              onSaved: (password) {
                _authData['password'] = password ?? '';
              },
              validator: (_password) {
                final password = _password ?? '';
                if (password.isEmpty || password.length < 6) {
                  return 'A senha deve ter pelo menos 6 caracteres!';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),

            // Campo de confirmação de senha (somente em modo Signup)
            if (_isSignup())
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Confirme a Senha',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (_password) {
                  if (_isLogin()) return null;
                  if (_password != _passwordController.text) {
                    return 'As senhas não coincidem!';
                  }
                  return null;
                },
              ),
            if (_isSignup()) const SizedBox(height: 15),

            const SizedBox(height: 10),

            // Botão de envio
            if (_isLoading)
              const CircularProgressIndicator()
            else
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(_isLogin() ? Icons.login : Icons.app_registration),
                  label: Text(_isLogin() ? 'ENTRAR' : 'REGISTRAR'),
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: theme.colorScheme.secondary,
                    foregroundColor: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            const SizedBox(height: 15),

            // Botão para alternar entre login e cadastro
            TextButton(
              onPressed: _switchAuthMode,
              child: Text.rich(
                TextSpan(
                  children: [
                    if (_isLogin()) ...[
                      const TextSpan(
                        text: 'Novo na PaPum?  ',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                    TextSpan(
                      text: _isLogin() ? ' Registrar' : 'Já possui uma conta?',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
