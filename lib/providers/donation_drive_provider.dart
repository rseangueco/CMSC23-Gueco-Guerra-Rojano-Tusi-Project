import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../api/firebase_donation_drive_api.dart';
import '../models/donation_drive_model.dart';

class DonationDriveProvider with ChangeNotifier {
  FirebaseDonationDriveAPI firebaseService = FirebaseDonationDriveAPI();
  late Stream<QuerySnapshot> _donationDriveListStream;

  DonationDriveProvider() {
    fetchDonationDriveList();
  }

  // Getter
  Stream<QuerySnapshot> get friend => _donationDriveListStream;

  void fetchDonationDriveList() {
    _donationDriveListStream = firebaseService.getDonationDriveList();
    notifyListeners();
  }

  void addDonationDrive(DonationDrive donationDrive) async {
    final result = await firebaseService
        .addDonationDrive(donationDrive.toJson(donationDrive));
    notifyListeners();
  }

  void editDonationDrive(String id, DonationDrive donationDrive) async {
    final result = await firebaseService.editDonationDrive(id, donationDrive);
    notifyListeners();
  }

  void deleteDonationDrive(String id) async {
    final result = await firebaseService.deleteDonationDrive(id);
    notifyListeners();
  }

  void addDonation(String donationId, String photo, String donationDriveId) {
    final result =
        firebaseService.addDonation(donationId, photo, donationDriveId);
    notifyListeners();
  }

  void deleteDonation(String donationId, String donationDriveId) {
    final result = firebaseService.deleteDonation(donationId, donationDriveId);
    notifyListeners();
  }
}
