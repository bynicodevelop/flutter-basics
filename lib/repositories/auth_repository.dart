import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:kdofavoris/exceptions/bad_credentials_exception.dart';
import 'package:kdofavoris/exceptions/email_altrady_exists_exception.dart';
import 'package:kdofavoris/exceptions/password_too_short_exception.dart';

class AuthRepository {
  final FirebaseAuth firebaseAuth;

  AuthRepository(this.firebaseAuth);

  Stream<User?> get isAuth => firebaseAuth.authStateChanges();

  Future<bool> get isAuthenticated async =>
      await firebaseAuth.authStateChanges().first != null;

  Future<void> register(String email, String password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw new EmailAlreadyExistsException();
      } else if (e.code == 'weak-password') {
        throw new PasswordTooShortException();
      }
    }
  }

  Future<void> connection(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found" || e.code == "wrong-password") {
        throw new BadCredentialsException();
      }
    }
  }

  Future<void> logout() async => await firebaseAuth.signOut();
}
