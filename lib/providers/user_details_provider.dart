import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../api/firebase_user_details_api.dart';
import '../models/userdetails_model.dart';

class UserDetailsProvider with ChangeNotifier {
  FirebaseUserDetailsAPI firebaseService = FirebaseUserDetailsAPI();
  late Stream<QuerySnapshot> _usersStream;

  UserDetailsProvider() {
    fetchUsers();
  }

  // getter
  Stream<QuerySnapshot> get user => _usersStream;

  void fetchUsers() {
    _usersStream = firebaseService.getAllUsers();
    notifyListeners();
  }

  Future<Map<String, dynamic>> getUserType(String id) async {
    final result = firebaseService.getUserType(id);
    notifyListeners();

    return result;
  }
}
