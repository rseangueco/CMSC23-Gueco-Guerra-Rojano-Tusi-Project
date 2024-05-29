import '../models/organization_model.dart';
import '../api/firebase_organization_api.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrganizationProvider with ChangeNotifier {
  FirebaseOrganizationAPI firebaseService = FirebaseOrganizationAPI();
  late Stream<QuerySnapshot> _organizationListStream;

  OrganizationProvider() {
    fetchOrganizationList();
  }

  // Getter
  Stream<QuerySnapshot> get organization => _organizationListStream;

  void fetchOrganizationList() {
    _organizationListStream = firebaseService.getOrganizationList();
    notifyListeners();
  }

  void editOrganization(String id, Organization organization) async {
    final result = await firebaseService.editOrganization(id, organization);
    notifyListeners();
  }

  void deleteOrganization(String id) async {
    final result = await firebaseService.deleteOrganization(id);
    notifyListeners();
  }

  void updateApprovalStatus(String id, int status) async {
    final result = await firebaseService.updateApprovalStatus(id, status);
    notifyListeners();
    
  void addOrganization(String name, String userId, Function(String) callback) async {
    firebaseService.addOrganization(name, userId).then((message) {
      callback(message);
      notifyListeners();
    }).catchError((error) {
      callback(error);
      notifyListeners();
    });
  }
}
