import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/userdetails_model.dart';

class FirebaseAuthAPI {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<User?> getUser() {
    return auth.authStateChanges();
  }


  Future<String?> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }


  Future<Map<String, dynamic>> signUp(String email, String password, Map<String, dynamic> userDetails) async {
    UserCredential credential;
    var result = {
      'error': '',
      'userId': ''
    };

    try {
      credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      String? userId = credential.user?.uid; // store uid generated upon sign up

      if (userId == null) {
        result['error'] = 'User ID is null';
        return result;
      }

      result['userId'] = userId;

      await db.collection("userdetails").doc(userId).set({
        'username': userDetails['username'],
        'name': userDetails['name'],
        'contactNo': userDetails['contactNo'],
        'address': userDetails['address'],
        'type': userDetails['type']
      });

    } on FirebaseAuthException catch (e) {
        result['error'] = e.code;
    }

    return result;
  }


  Future<void> addOrgId(String userId, String orgId) async {
    try{
      await db.collection("userdetails").doc(userId).update({
        'organizationId': orgId
      });
    }
    on FirebaseException catch (e){
      print(e);
    }
  }


  Future<void> signOut() async {
    await auth.signOut();
  }


  Future<UserDetails?> fetchUserDetails(String userId) async {
    try {
      DocumentSnapshot docRef = await db.collection('userdetails').doc(userId).get();
      return UserDetails.fromJson(docRef.data() as Map<String, dynamic>);
    } catch (e) {
      print('Failed to fetch user details: $e');
      return null;
    }
  }
}
