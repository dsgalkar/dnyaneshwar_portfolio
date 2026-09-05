import 'package:flutter/material.dart';

enum UserRole { guest, admin }

/// State container for Guest vs Admin Authentication
class AuthState extends ChangeNotifier {
  UserRole _role = UserRole.guest;
  String _adminUsername = 'dnyaneshwar';

  UserRole get role => _role;
  bool get isAdmin => _role == UserRole.admin;
  bool get isGuest => _role == UserRole.guest;
  String get adminUsername => _adminUsername;

  // Master credentials (can easily be connected to Firebase Auth)
  static const String masterUsername = 'admin';
  static const String masterPassword = 'admin';
  static const String developerPin = '1337';

  /// Sign in as Admin
  bool signIn(String username, String password) {
    final String u = username.trim().toLowerCase();
    final String p = password.trim();

    if ((u == masterUsername || u == 'dnyaneshwar' || u == 'root') &&
        (p == masterPassword || p == developerPin || p == 'flutter2025')) {
      _role = UserRole.admin;
      _adminUsername = username.trim();
      notifyListeners();
      return true;
    }
    return false;
  }

  /// Sign out back to default Guest mode
  void signOut() {
    _role = UserRole.guest;
    notifyListeners();
  }
}
