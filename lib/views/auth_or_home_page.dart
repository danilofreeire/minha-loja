import 'package:flutter/material.dart';
import 'package:minha_loja/models/auth.dart';
import 'package:minha_loja/views/auth_view.dart';
import 'package:minha_loja/views/prodcuts_overview_view.dart';
import 'package:provider/provider.dart';

class AuthOrHomePage extends StatelessWidget {
  const AuthOrHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);
    return auth.isAuth ? ProdcutsOverviewView() : AuthView();
  }
}
