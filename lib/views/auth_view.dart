import 'package:flutter/material.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
        Center(
          child: Card(
            elevation: 8,
            margin: const EdgeInsets.all(16),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Auth Form'),
            ),
          ),
        ),
      ],
    );
  }
}
