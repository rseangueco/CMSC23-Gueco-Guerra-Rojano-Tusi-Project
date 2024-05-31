import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23_project/models/organization_model.dart';

class FirebaseOrganizationAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getApprovedOrganizations() {
    return db
        .collection("organizations")
        .where('approvalStatus', isEqualTo: 'Approved')
        .snapshots();
  }

  Stream<QuerySnapshot> getPendingOrganizations() {
    return db
        .collection("organizations")
        .where('approvalStatus', isEqualTo: 'Pending')
        .snapshots();
  }

  Future<Map<String, dynamic>> addOrganization(
      String name, List<String> proofs, String userId) async {
    try {
      final docRef = await db.collection("organizations").add({
        'name': name,
        'proofs': proofs,
        'donationStatus': 'Pending',
        'approvalStatus': 'Pending',
        'userId': userId
      });

      return {'success': true, 'message': docRef.id};
    } on FirebaseException catch (e) {
      return {'success': false, 'message': "Error in ${e.code}: ${e.message}"};
    }
  }

  Future<Map<String, dynamic>> editOrganization(
      String id, Organization organization) async {
    try {
      await db.collection("organizations").doc(id).update({
        "name": organization.name,
        "about": organization.about,
        "donationStatus": organization.donationStatus
      });
      return {
        'success': true,
        'message': "Organization has been successfully updated!"
      };
    } on FirebaseException catch (e) {
      return {'success': false, 'message': "Error in ${e.code}: ${e.message}"};
    }
  }

  Future<Map<String, dynamic>> deleteOrganization(String id) async {
    try {
      await db.collection("organizations").doc(id).delete();

      return {'success': true, 'message': "Organization has been deleted."};
    } on FirebaseException catch (e) {
      return {'success': false, 'message': "Error in ${e.code}: ${e.message}"};
    }
  }

  String addDonation(String id, String donationId) {
    final docRef = db.collection("organizations").doc(id);
    docRef.get().then((DocumentSnapshot doc) {
      if (doc.exists) {
        Organization organization =
            Organization.fromJson(doc.data() as Map<String, dynamic>);
        organization.donations ??= [donationId];
        final result =
            editOrganization(id, organization) as Map<String, dynamic>;
        if (result['success'] = true) {
          return "Donation has been successfully added to Organization";
        } else {
          return result['message'];
        }
      } else {
        return "Organization cannot be found.";
      }
    }, onError: (e) {
      return "Error getting Organization: $e";
    });

    return "Donation has been successfully added";
  }

  Future<Map<String, dynamic>> updateApprovalStatus(
      String id, int status) async {
    try {
      await db
          .collection("organizations")
          .doc(id)
          .update({"approvalStatus": status});

      return {
        'success': true,
        'message': "Approval status has been updated, organization is $status"
      };
    } on FirebaseException catch (e) {
      return {'success': false, 'message': "Error in ${e.code}: ${e.message}"};
    }
  }
}
