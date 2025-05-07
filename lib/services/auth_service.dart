import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  static const _authTokenKey = 'auth_token';
  String? _token;
  String? get token => _token;
  String? name = '';
  bool isLoading = false;

  AuthService() {
    loadToken();
  }

  void setIsLoading(bool r) {
    isLoading = r;
    notifyListeners();
  }

  String get getname => name!;
  void setname(String name) {
    this.name = name;
    notifyListeners();
  }

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString(_authTokenKey);
    notifyListeners();
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_authTokenKey, token);
    _token = token;
    isLoading = false;
    notifyListeners();
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_authTokenKey);
    _token = null;
    notifyListeners();
  }

  // bool get isAuthenticated => _token != null && !isTokenExpired;
  bool get isAuthenticated => _token != null;
}
