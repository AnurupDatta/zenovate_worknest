import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthService extends ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;
  String? _error;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _currentUser != null;

  // Simulated user database
  final Map<String, User> _users = {
    'admin@zenovate.com': User(
      id: '1',
      name: 'Admin User',
      email: 'admin@zenovate.com',
      phone: '1234567890',
      department: 'Management',
      joinDate: DateTime.now(),
      role: UserRole.admin,
      status: UserStatus.active,
    ),
    'manager@zenovate.com': User(
      id: '2',
      name: 'Manager User',
      email: 'manager@zenovate.com',
      phone: '1234567891',
      department: 'HR',
      joinDate: DateTime.now(),
      role: UserRole.manager,
      status: UserStatus.active,
    ),
  };

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      if (_users.containsKey(email)) {
        _currentUser = _users[email];
        // Save session
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_email', email);
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = 'Invalid email or password';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = 'An error occurred during login';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    _currentUser = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_email');
    notifyListeners();
  }

  Future<bool> checkSession() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('user_email');
    if (email != null && _users.containsKey(email)) {
      _currentUser = _users[email];
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> signUp({
    required String name,
    required String email,
    required String phone,
    required String department,
    required UserRole role,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      if (_users.containsKey(email)) {
        _error = 'Email already exists';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final newUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        phone: phone,
        department: department,
        joinDate: DateTime.now(),
        role: role,
        status: UserStatus.active,
      );

      _users[email] = newUser;
      _currentUser = newUser;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'An error occurred during sign up';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
} 