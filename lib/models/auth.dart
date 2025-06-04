import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:minha_loja/exceptions/auth_exception.dart';

class Auth with ChangeNotifier {
  static const _url =
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAQY_GptkgvwyJ7Rtz4CC5cI-2uFwcNylw';

  Future<void> _authenticate(
    String email,
    String password,
    String urlFragment,
  ) async {
    final url = Uri.parse(
      'https://identitytoolkit.googleapis.com/v1/accounts:$urlFragment?key=AIzaSyAQY_GptkgvwyJ7Rtz4CC5cI-2uFwcNylw',
    );
    final response = await http.post(
      url,
      body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );
    final body = jsonDecode(response.body);
    print(body);

    if (body['error'] != null) {
      throw AuthException(body['error']['message'].toString());
    }
    print(body);
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, 'signUp');
    // Armazenar o token ou fazer outras ações necessárias
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
    // Armazenar o token ou fazer outras ações necessárias
  }
}
