import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/userdetails_model.dart';
import '../api/firebase_auth_api.dart';

class AuthProvider with ChangeNotifier {
  late FirebaseAuthAPI authService;

  late Stream<User?> uStream;
  User? userObj;

  AuthProvider() {
    authService = FirebaseAuthAPI();
    fetchAuthentication();
  }

  Stream<User?> get userStream => uStream;
  void fetchAuthentication() {
    uStream = authService.getUser();
    notifyListeners();
  }

  Future<String?> signUp(String email, String password, UserDetails userDetails) async {
    String? errorCode = await authService.signUp(email, password, userDetails.toJson(userDetails));
    notifyListeners();

    return errorCode;
  }

  Future<void> signIn(String email, String password) async {
    await authService.signIn(email, password);
    notifyListeners();
  }

  Future<void> signOut() async {
    await authService.signOut();
    notifyListeners();
  }
}