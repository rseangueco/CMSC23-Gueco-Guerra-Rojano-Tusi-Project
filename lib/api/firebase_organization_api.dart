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

      return docRef.id;
    } on FirebaseException catch (e) {
      return e.code;
    }
  }
}