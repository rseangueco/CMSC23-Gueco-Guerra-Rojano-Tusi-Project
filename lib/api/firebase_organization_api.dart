import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseOrganizationAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getOrganizationList() {
    return db.collection("organizations").snapshots();
  }

  Future<String> addOrganization(String name) async {
    try {
      final docRef = await db.collection("organizations").add({
        'name': name,
        'status': 'Pending',
      });

      await db.collection("organization").doc(docRef.id).update({'id': docRef.id});

      return "Successfully added organization.";
    } on FirebaseException catch (e) {
      return e.code;
    }
  }
}