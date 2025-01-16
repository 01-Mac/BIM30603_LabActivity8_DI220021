import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';

class AuthMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign up user
  Future<String> signupUser({
    required String email,
    required String password,
    required String confirmPassword,
    required String name,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          confirmPassword.isNotEmpty ||
          name.isNotEmpty) {
        if (password == confirmPassword) {
          // Register in Firebase Auth
          UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );

          // Add user in Firestore
          await _firestore.collection("users").doc(cred.user!.uid).set({
            'uname': name,
            'uid': cred.user!.uid,
            'uemail': email,
          });

          res = "success";
        } else {
          res = "Password and Confirm Password are not the same. Please check.";
        }
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // Login user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // Login using Firebase Auth
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all fields";
      }
    } catch (err) {
      return err.toString();
    }

    return res;
  }

  // Sign out
  googleSignOut() async {
    await _auth.signOut();
  }
}
