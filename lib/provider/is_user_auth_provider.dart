import 'package:flutter/material.dart';

class IsUserAuthProvider extends ChangeNotifier {
  String _token = "";
  String get token => _token;

  void setToken(String token) {
    _token = token;
    notifyListeners();
  }

  void clearToken() {
    _token = '';
    notifyListeners();
  }
}
