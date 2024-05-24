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

  Future<Map<String, dynamic>> signUp(String email, String password, UserDetails userDetails) async {
    Map<String, dynamic> signupResult = await authService.signUp(email, password, userDetails.toJson(userDetails));
    notifyListeners();

    return signupResult;
  }

  Future<void> signIn(String email, String password) async {
    await authService.signIn(email, password);
    notifyListeners();
  }

  Future<void> addOrgId(String userid, String orgId) async {
    await authService.addOrgId(userid, orgId);
    notifyListeners();
  }

  Future<void> signOut() async {
    await authService.signOut();
    notifyListeners();
  }
}