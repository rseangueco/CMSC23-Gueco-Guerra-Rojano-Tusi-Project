import '../api/firebase_organization_api.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrganizationListProvider with ChangeNotifier {
  FirebaseOrganizationAPI firebaseService = FirebaseOrganizationAPI();
  late Stream<QuerySnapshot> _organizationListStream;

  OrganizationListProvider() {
    fetchOrganizationList();
  }

  // Getter
  Stream<QuerySnapshot> get organization => _organizationListStream;

  void fetchOrganizationList() {
    _organizationListStream = firebaseService.getOrganizationList();
    notifyListeners();
  }

  void addOrganization(String name) async {
    await firebaseService.addOrganization(name);

    notifyListeners();
  }
}