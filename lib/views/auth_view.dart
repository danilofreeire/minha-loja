import 'dart:math';

import 'package:flutter/material.dart';
import 'package:minha_loja/widgets/auth_form.dart';

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
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 70,
                  vertical: 10,
                ),
                transform: Matrix4.rotationZ(-8 * pi / 180)..translate(-10.0),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Text(
                  'Minha Loja',
                  style: TextStyle(
                    fontSize: 45,
                    fontFamily: 'Anton',
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              AuthForm(),
            ],
          ),
        ),
      ],
    );
  }
}
