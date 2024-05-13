import 'package:cmsc23_project/api/firebase_organization_list_api.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrganizationListProvider with ChangeNotifier {
  FirebaseOrganizationListAPI firebaseService = FirebaseOrganizationListAPI();
  late Stream<QuerySnapshot> _organizationListStream;

  OrganizationListProvider() {
    fetchFriendsList();
  }

  // Getter
  Stream<QuerySnapshot> get organization => _organizationListStream;

  void fetchFriendsList() {
    _organizationListStream = firebaseService.getOrganizationList();
    notifyListeners();
  }
}
