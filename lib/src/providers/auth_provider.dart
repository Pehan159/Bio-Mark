// lib/src/providers/auth_provider.dart

import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthsProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  User? _user;
  String _errorMessage = '';

  User? get user => _user;
  String get errorMessage => _errorMessage;

  // Register a new user
  Future<User?> register(String email, String password) async {
    try {
      _user = await _authService.registerWithEmailAndPassword(email, password);
      notifyListeners();
      return _user;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return null;
    }
  }

  // Login existing user
  Future<User?> login(String email, String password) async {
    try {
      _user = await _authService.loginWithEmailAndPassword(email, password);
      notifyListeners();
      return _user;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return null;
    }
  }

  // Logout user
  Future<void> logout() async {
    await _authService.logout();
    _user = null;
    notifyListeners();
  }
}
