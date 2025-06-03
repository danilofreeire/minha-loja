import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  static const _url =
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAQY_GptkgvwyJ7Rtz4CC5cI-2uFwcNylw';
  Future<void> signUp(String email, String password) async {
    final response = await http.post(
      Uri.parse(_url),
      body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );
    print(jsonDecode(response.body));

    // Armazenar o token ou fazer outras ações necessárias
    notifyListeners();
  }
}
