import 'package:firebase_app/auth/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;

  static bool isLoggedIn() {
    final User? firebaseUser = _auth.currentUser;
    return firebaseUser != null;
  }

  static Future<User?> login(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    final User? firebaseUser = _auth.currentUser;
    return firebaseUser;
  }

  static Future<User?> register(
    String name,
    String email,
    String password,
  ) async {
    var result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? user = result.user;
    return user;
  }

  static void logOut(BuildContext context) {
    _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) {
          return LoginPage();
        },
      ),
    );
  }
}
