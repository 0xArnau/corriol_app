import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  void userReload() => currentUser!.reload();

  bool isEmailVerified() {
    userReload();
    return currentUser!.emailVerified;
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    _firebaseAuth.signOut();
  }

  Future<String> sendEmailVerification() async {
    String status = '';
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      status = 'Email send';
    } catch (e) {
      status = e.toString();
    }
    return status;
  }
}