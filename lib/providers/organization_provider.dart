import '../models/organization_model.dart';
import '../api/firebase_organization_api.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrganizationProvider with ChangeNotifier {
  FirebaseOrganizationAPI firebaseService = FirebaseOrganizationAPI();
  late Stream<QuerySnapshot> _approvedOrganizationsStream;
  late Stream<QuerySnapshot> _pendingOrganizationsStream;

  OrganizationProvider() {
    fetchApprovedOrganizations();
    fetchPendingOrganizations();
  }

  // Getter
  Stream<QuerySnapshot> get approved => _approvedOrganizationsStream;
  Stream<QuerySnapshot> get pending => _pendingOrganizationsStream;

  void fetchApprovedOrganizations() {
    _approvedOrganizationsStream = firebaseService.getApprovedOrganizations();
    notifyListeners();
  }

  void fetchPendingOrganizations() {
    _pendingOrganizationsStream = firebaseService.getPendingOrganizations();
    notifyListeners();
  }

  void addOrganization(String name, List<String> proofs, String userId,
      Function(String) callback) async {
    firebaseService.addOrganization(name, proofs, userId).then((message) {
      callback(message['message']);
      notifyListeners();
    }).catchError((error) {
      callback(error);
      notifyListeners();
    });
  }

  Future<Map<String, dynamic>> editOrganization(
      String id, Organization organization) async {
    final result = await firebaseService.editOrganization(id, organization);
    notifyListeners();

    return result;
  }

  Future<Map<String, dynamic>> deleteOrganization(String id) async {
    final result = await firebaseService.deleteOrganization(id);
    notifyListeners();

    return result;
  }

  Future<Map<String, dynamic>> updateApprovalStatus(
      String id, int status) async {
    final result = await firebaseService.updateApprovalStatus(id, status);
    notifyListeners();

    return result;
  }

  Future<Map<String, dynamic>> addDonation(String id, String donationId) async {
    final result = await firebaseService.addDonation(id, donationId);
    notifyListeners();

    return result;
  }
}
