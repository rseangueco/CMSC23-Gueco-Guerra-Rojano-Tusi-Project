import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/donation_model.dart';

class FirebaseDonationAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getDonationList() {
    return db.collection("donations").snapshots();
  }

  Stream<QuerySnapshot> getDonorDonations(String userId) {
    return db
        .collection("donations")
        .where('userId', isEqualTo: userId)
        .snapshots();
  }

  Stream<QuerySnapshot> getOrganizationDonations(String organizationId) {
    return db
        .collection("donations")
        .where('organizationId', isEqualTo: organizationId)
        .snapshots();
  }

  Future<Map<String, dynamic>> addDonation(
      Map<String, dynamic> donation) async {
    try {
      final docRef = await db.collection("donations").add(donation);
      return {'success': true, 'message': docRef.id};
    } on FirebaseException catch (e) {
      return {'success': false, 'message': "Error in ${e.code}: ${e.message}"};
    }
  }

  Future<Map<String, dynamic>> editDonation(
      String id, Donation donation) async {
    try {
      await db.collection("donations").doc(id).update({
        "category": donation.category,
        "weight": donation.weight,
        "collectionMethod": donation.collectionMethod,
        "photo": donation.photo,
        "collectionDate": donation.collectionDate,
        "collectionTime": donation.collectionTime,
        "pickupContactNo": donation.pickupContactNo,
        "pickupAddress": donation.pickupAddress,
        "organizationId": donation.organizationId
      });
      return {
        'success': true,
        'message': "Donation has been successfully edited!"
      };
    } on FirebaseException catch (e) {
      return {'success': false, 'message': "Error in ${e.code}: ${e.message}"};
    }
  }

  Future<Map<String, dynamic>> deleteDonation(String id) async {
    try {
      await db.collection("donations").doc(id).delete();

      return {'success': true, 'message': "Donation has been deleted."};
    } on FirebaseException catch (e) {
      return {'success': false, 'message': "Error in ${e.code}: ${e.message}"};
    }
  }

  Future<Map<String, dynamic>> updateStatus(String id, String status) async {
    try {
      await db.collection("donations").doc(id).update({"status": status});

      return {
        'success': true,
        'message': "Donation status has been updated, donation is $status"
      };
    } on FirebaseException catch (e) {
      return {'success': false, 'message': "Error in ${e.code}: ${e.message}"};
    }
  }

  Future<Map<String, dynamic>> addDonationDrive(
      String donationId, String donationDriveId) async {
    try {
      await db
          .collection("donations")
          .doc(donationId)
          .update({"donationDriveId": donationDriveId});

      return {
        'success': true,
        'message': "Donation has been successfully added to a donation drive"
      };
    } on FirebaseException catch (e) {
      return {'success': false, 'message': "Error in ${e.code}: ${e.message}"};
    }
  }
}
