import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../api/firebase_donation_api.dart';
import '../models/donation_model.dart';

class DonationProvider with ChangeNotifier {
  FirebaseDonationAPI firebaseService = FirebaseDonationAPI();
  late Stream<QuerySnapshot> _donationsStream;

  DonationProvider() {
    fetchDonations();
  }

  // Getter
  Stream<QuerySnapshot> get donations => _donationsStream;

  void fetchDonations() {
    _donationsStream = firebaseService.getDonationList();
    notifyListeners();
  }

  Stream<QuerySnapshot> fetchDonorDonations(String userId) {
    Stream<QuerySnapshot> donorDonationStream =
        firebaseService.getDonorDonations(userId);
    notifyListeners();

    return donorDonationStream;
  }

  Stream<QuerySnapshot> fetchOrganizationDonations(String userId) {
    Stream<QuerySnapshot> organizationDonationStream =
        firebaseService.getOrganizationDonations(userId);
    notifyListeners();

    return organizationDonationStream;
  }

  Future<Map<String, dynamic>> addDonation(Donation donation) async {
    final result = await firebaseService.addDonation(donation.toJson(donation));
    notifyListeners();

    return result;
  }

  Future<Map<String, dynamic>> editDonation(
      String id, Donation donation) async {
    final result = await firebaseService.editDonation(id, donation);
    notifyListeners();

    return result;
  }

  Future<Map<String, dynamic>> deleteDonation(String id) async {
    final result = await firebaseService.deleteDonation(id);
    notifyListeners();

    return result;
  }

  Future<Map<String, dynamic>> updateStatus(String id, String newStatus) async {
    final result = firebaseService.updateStatus(id, newStatus);
    notifyListeners();

    return result;
  }
}
