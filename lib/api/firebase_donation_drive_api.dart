import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/donation_drive_model.dart';

class FirebaseDonationDriveAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getDonationDriveList() {
    return db.collection("donationsDrives").snapshots();
  }

  Future<Map<String, dynamic>> addDonationDrive(
      Map<String, dynamic> donationDrive) async {
    try {
      await db.collection("donationsDrives").add(donationDrive);

      return {
        'success': true,
        'message': "Donation Drive has been successfully added!"
      };
    } on FirebaseException catch (e) {
      return {'success': false, 'message': "Error in ${e.code}: ${e.message}"};
    }
  }

  Future<Map<String, dynamic>> editDonationDrive(
      String id, DonationDrive donationDrive) async {
    try {
      await db.collection("donationsDrives").doc(id).update({
        "title": donationDrive.title,
        "description": donationDrive.description,
        "photos": donationDrive.photos,
        "donations": donationDrive.donations
      });
      return {
        'success': true,
        'message': "Donation Drive has been successfully updated!"
      };
    } on FirebaseException catch (e) {
      return {'success': false, 'message': "Error in ${e.code}: ${e.message}"};
    }
  }

  Future<Map<String, dynamic>> deleteDonationDrive(String id) async {
    try {
      await db.collection("donationsDrives").doc(id).delete();

      return {'success': true, 'message': "Donation Drive has been deleted."};
    } on FirebaseException catch (e) {
      return {'success': false, 'message': "Error in ${e.code}: ${e.message}"};
    }
  }

  String addDonation(String donationId, String photo, String donationDriveId) {
    final docRef = db.collection("donationsDrives").doc(donationDriveId);
    docRef.get().then((DocumentSnapshot doc) {
      if (doc.exists) {
        DonationDrive donationDrive =
            DonationDrive.fromJson(doc.data() as Map<String, dynamic>);
        donationDrive.donations.add(donationId);
        donationDrive.photos[donationId] = photo;
        final result = editDonationDrive(donationDriveId, donationDrive)
            as Map<String, dynamic>;
        if (result['success'] = true) {
          return "Donation has been successfully added to Donation Drive";
        } else {
          return result['message'];
        }
      } else {
        return "Donation Drive cannot be found.";
      }
    }, onError: (e) {
      return "Error getting Donation Drive: $e";
    });

    return "Donation has been successfully added";
  }

  String deleteDonation(String donationId, String donationDriveId) {
    final docRef = db.collection("donationsDrives").doc(donationDriveId);
    docRef.get().then((DocumentSnapshot doc) {
      if (doc.exists) {
        DonationDrive donationDrive =
            DonationDrive.fromJson(doc.data() as Map<String, dynamic>);
        if (donationDrive.donations.remove(donationId)) {
          donationDrive.photos.remove(donationId);
          final result = editDonationDrive(donationDriveId, donationDrive)
              as Map<String, dynamic>;
          if (result['success'] = true) {
            return "Donation has been successfully added to Donation Drive";
          } else {
            return result['message'];
          }
        } else {
          return "Donation Drive cannot be found.";
        }
      } else {
        return "Donation Drive cannot be found.";
      }
    }, onError: (e) {
      return "Error getting Donation Drive: $e";
    });

    return "Donation has been successfully added";
  }
}
