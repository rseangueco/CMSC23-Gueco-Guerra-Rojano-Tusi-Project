import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthAPI {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<User?> getUser() {
    return auth.authStateChanges();
  }

  Future<String?> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: email, password: password);
        return null;
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future<String?> signUp(String email, String password, Map<String, dynamic> userDetails) async {
    UserCredential credential;
    try {
      credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      String? userId = credential.user?.uid; // store uid generated upon sign up

      await db.collection("userdetails").doc(userId).set({
        'username': userDetails['username'],
        'name': userDetails['name'],
        'contactNo': userDetails['contactNo'],
        'address': userDetails['address'],
        'type': userDetails['type']
      });

    } on FirebaseAuthException catch (e) {
        return e.code;
    }
    return null;
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
