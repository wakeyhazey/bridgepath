import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthApi {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? getUser() {
    User? user = FirebaseAuth.instance.currentUser;
    return user;
  }

  Future<User?> logIn(Map<String, TextEditingController> credentials) async {
    try {
      return await _auth
          .signInWithEmailAndPassword(
              email: credentials['username']!.text,
              password: credentials['password']!.text)
          .then((userCredential) => userCredential.user);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<User?> register(Map<String, TextEditingController> credentials) async {
    try {
      return await _auth
          .createUserWithEmailAndPassword(
              email: credentials['email']!.text,
              password: credentials['password']!.text)
          .then((userCredential) => userCredential.user);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  logOut() async {
    await _auth.signOut();
  }
}
