import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthApi {
  static final _handler = GoogleSignIn();

  static Future<GoogleSignInAccount?> login() => _handler.signIn();

  static Future<void> signout() => _handler.signOut();

  static Future<bool> isConnected() => _handler.isSignedIn();
}