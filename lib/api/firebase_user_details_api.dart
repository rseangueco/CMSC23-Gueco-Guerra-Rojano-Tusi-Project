import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23_project/models/userdetails_model.dart';

class FirebaseUserDetailsAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getUserType(String id) async {
    try {
      DocumentSnapshot documentSnapshot =
          await db.collection("userdetails").doc(id).get();
      if (documentSnapshot.exists) {
        UserDetails userDetails = UserDetails.fromJson(
            documentSnapshot.data() as Map<String, dynamic>);
        String type = userDetails.type;
        return {'success': true, 'message': type};
      } else {
        return {'success': false, 'message': "User cannot be found"};
      }
    } catch (e) {
      return {'success': false, 'message': "Error getting Details: $e"};
    }
  }

  Future<Map<String, dynamic>> getUsername(String id) async {
    try {
      DocumentSnapshot documentSnapshot =
          await db.collection("userdetails").doc(id).get();
      if (documentSnapshot.exists) {
        UserDetails userDetails = UserDetails.fromJson(
            documentSnapshot.data() as Map<String, dynamic>);
        String username = userDetails.type;
        return {'success': true, 'message': username};
      } else {
        return {'success': false, 'message': "User cannot be found"};
      }
    } catch (e) {
      return {'success': false, 'message': "Error getting User Details: $e"};
    }
  }

  Future<Map<String, dynamic>> getOrganizationId(String id) async {
    try {
      DocumentSnapshot documentSnapshot =
          await db.collection("userdetails").doc(id).get();
      if (documentSnapshot.exists) {
        UserDetails userDetails = UserDetails.fromJson(
            documentSnapshot.data() as Map<String, dynamic>);
        String organizationId = userDetails.organizationId!;
        return {'success': true, 'message': organizationId};
      } else {
        return {'success': false, 'message': "User cannot be found"};
      }
    } catch (e) {
      return {'success': false, 'message': "Error getting Details: $e"};
    }
  }

  Stream<QuerySnapshot> getAllUsers() {
    return db.collection("userdetails").snapshots();
  }
}
