import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:minha_loja/exceptions/auth_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _userId;
  String? _email;
  DateTime? _expiryDate;
  Timer? _logoutTimer;

  bool get isAuth {
    final isValid = _expiryDate != null && _expiryDate!.isAfter(DateTime.now());
    return _token != null && isValid;
  }

  String? get token {
    return isAuth ? _token : null;
  }

  String? get userId {
    return isAuth ? _userId : null;
  }

  String? get email {
    return isAuth ? _email : null;
  }

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
    } else {
      _token = body['idToken'];
      _userId = body['localId'];
      _email = body['email'];
      _expiryDate = DateTime.now().add(
        Duration(seconds: int.parse(body['expiresIn'])),
      );
      _autoLogout();
      notifyListeners();
    }
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, 'signUp');
    // Armazenar o token ou fazer outras ações necessárias
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
    // Armazenar o token ou fazer outras ações necessárias
  }

  void logout() {
    _token = null;
    _userId = null;
    _email = null;
    _expiryDate = null;
    _clearAutoLogoutTimer();
    notifyListeners();
  }

  void _clearAutoLogoutTimer() {
    _logoutTimer?.cancel();
    _logoutTimer = null;
  }

  void _autoLogout() {
    _clearAutoLogoutTimer();
    final timeToLogout = _expiryDate?.difference(DateTime.now()).inSeconds;
    _logoutTimer = Timer(Duration(seconds: timeToLogout ?? 0), logout);
  }
}
