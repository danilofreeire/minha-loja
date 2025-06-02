import 'package:flutter/material.dart';
import 'package:minha_loja/widgets/auth_form.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fundo com gradiente
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(211, 78, 196, 255),
                  Color.fromARGB(255, 16, 77, 209),
                ],
              ),
            ),
          ),
          // Conteúdo central
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Texto "ACESSE SUA CONTA"
                  Text(
                    'ACESSE SUA CONTA',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Card com campos do AuthForm
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const AuthForm(), // ← Seus campos de e-mail e senha
                          const SizedBox(height: 10),

                          const Divider(),
                          const SizedBox(height: 10),

                          // Texto social
                          const Text(
                            'QUERO ACESSAR COM MINHAS REDES SOCIAIS',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Botão Google
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              icon: const Icon(
                                Icons.g_mobiledata,
                                color: Colors.red,
                              ),
                              label: const Text(
                                "Acessar com o Google",
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.red),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Botão Apple
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              icon: const Icon(
                                Icons.apple,
                                color: Colors.black,
                              ),
                              label: const Text(
                                "Acessar com a Apple",
                                style: TextStyle(color: Colors.black),
                              ),
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.black),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Link cadastre-se
                          GestureDetector(
                            onTap: () {},
                            child: RichText(
                              text: const TextSpan(
                                text: 'Novo na PaPuM? ',
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: 'CADASTRE-SE',
                                    style: TextStyle(
                                      color: Colors.orange,
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
