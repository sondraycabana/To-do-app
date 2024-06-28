import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/auth_service.dart';


class AuthProvider extends ChangeNotifier {


  String? _uid;

  String? get uid => _uid;

  User? _user;
  User? get user => _user;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  AuthProvider() {
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    _user = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }

  Future<void> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      _user = await FireAuth.registerUsingEmailPassword(
        name: name,
        email: email,
        password: password,
        context: context,
      );
      notifyListeners();
    } catch (e) {
      _showError(context, e.toString());
    }
  }

  Future<void> signInUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      _user = await FireAuth.signInUsingEmailPassword(
        email: email,
        password: password,
      );
      notifyListeners();
    } catch (e) {
      _showError(context, e.toString());
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      _user = await FireAuth.signInWithGoogle(context);
      notifyListeners();
    } catch (e) {
      _showError(context, e.toString());
    }
  }

  Future<void> signOut(BuildContext context) async {
    await FireAuth.signOut(context);
    _user = null;
    notifyListeners();
  }

  void _showError(BuildContext context, String message) {
    final snackBar = FireAuth.customSnackBar(content: message);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
