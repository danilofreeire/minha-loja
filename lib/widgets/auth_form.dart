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
      _authMode =
          _authMode == AuthMode.Login ? AuthMode.Signup : AuthMode.Login;
    });
  }

  void _submit() {
    final isValid = _globalKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    setState(() {
      _isLoading = true;
    });
    _globalKey.currentState?.save();

    if (_isLogin()) {
      // Perform login logic
      print('Logging in with email: ${_authData['email']}');
    } else {
      // Perform signup logic
      print('Signing up with email: ${_authData['email']}');
    }

    setState(() {
      _isLoading = false;
    });
  }

  bool _isLogin() {
    return _authMode == AuthMode.Login;
  }

  bool _isSingup() {
    return _authMode == AuthMode.Signup;
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: deviceSize.width * 0.75,
        height: _isLogin() ? 310 : 400,
        child: Form(
          key: _globalKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (email) {
                  _authData['email'] = email ?? '';
                },
                validator: (_email) {
                  final email = _email ?? '';

                  if (_email == null ||
                      _email.isEmpty ||
                      !_email.contains('@')) {
                    return 'Informe um e-mail válido!';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                controller: _passwordController,
                onSaved: (password) {
                  _authData['password'] = password ?? '';
                },
                validator: (_password) {
                  final password = _password ?? '';

                  if (_password == null ||
                      _password.isEmpty ||
                      _password.length < 6) {
                    return 'A senha deve ter pelo menos 6 caracteres!';
                  }
                  return null;
                },
              ),
              if (_isSingup())
                TextFormField(
                  decoration: InputDecoration(labelText: 'Confirme a Senha'),
                  obscureText: true,
                  validator:
                      _isLogin()
                          ? null
                          : (_password) {
                            final password = _password ?? '';

                            if (_password != _passwordController.text) {
                              return 'As senhas não coincidem!';
                            }
                            return null;
                          },
                ),
              const SizedBox(height: 20),
              if (_isLoading)
                CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: _submit,
                  child: Text(_isLogin() ? 'Entrar' : 'Registrar'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
              Spacer(),
              TextButton(
                onPressed: _switchAuthMode,
                child: Text(_isLogin() ? 'Registrar' : 'Já possui uma conta?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
