import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<UserCredential> signUp(String email, String password) async {
    UserCredential userCredential;
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return userCredential;
  }

  Future<UserCredential> signIn(String email, String password) async {
    var userCredential;
    try {
      userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }
    return userCredential;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> changePassword(String newPassword) async {
    await FirebaseAuth.instance.currentUser.updatePassword(newPassword);
  }
}
