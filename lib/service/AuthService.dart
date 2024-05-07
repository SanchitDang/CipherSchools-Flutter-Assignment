import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cipher_schools_flutter_assignment/screens/intro_screen.dart';
import '../helper/SharedPreferencesService.dart';
import 'DatabaseService.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // login
  Future loginWithUserNameAndPassword(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password);

      QuerySnapshot snapshot =
      await DatabaseService().gettingUserData(email);
      // saving the values to our shared preferences
      await SharedPreferencesService.saveUserLoggedInStatus(true);
      await SharedPreferencesService.saveUserEmailSF(password);
      await SharedPreferencesService.saveUserProfilePicSF(
          snapshot.docs[0]['profilePic']);
      await SharedPreferencesService.saveUserNameSF(
          snapshot.docs[0]['fullName']);
      await SharedPreferencesService.saveUserIDSF(snapshot.docs[0]['uid']);

      return true;

    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // register
  Future registerUserWithEmailAndPassword(
      String fullName, String email, String password, String img) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;
      await DatabaseService().savingUserData(user.uid, fullName, email, img);
      await SharedPreferencesService.saveUserLoggedInStatus(true);
      await SharedPreferencesService.saveUserEmailSF(email);
      await SharedPreferencesService.saveUserProfilePicSF(img);
      await SharedPreferencesService.saveUserNameSF(fullName);
      await SharedPreferencesService.saveUserIDSF(user.uid);
      return true;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // sign-out
  Future signOut(BuildContext context) async {
    try {
      await SharedPreferencesService.saveUserLoggedInStatus(false);
      await SharedPreferencesService.saveUserEmailSF("");
      await SharedPreferencesService.saveUserNameSF("");
      await firebaseAuth.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => IntroScreen()),
        (route) => false,
      );
    } catch (e) {
      return null;
    }
  }
}
