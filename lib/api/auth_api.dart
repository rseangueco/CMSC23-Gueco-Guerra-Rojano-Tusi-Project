import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthAPI {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<User?> getUser() {
    return auth.authStateChanges();
  }

  Future<void> signIn(String email, String password) async {
    UserCredential credential;
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<String?> signUp(String email, String password, Map<String, dynamic> userDetails) async {
    UserCredential credential;
    try {
      credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print(credential);

      String? userId = credential.user?.uid; // store uid generated upon sign up

      await db.collection('userdetails').add(userDetails);
      await db.collection("userdetails").doc(userId).set({
      'username': userDetails['username'],
      'contactNo': userDetails['contactNo'],
      'address': userDetails['address']
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
