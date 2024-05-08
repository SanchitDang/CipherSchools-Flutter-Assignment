import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cipher_schools_flutter_assignment/screens/intro_screen.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../helper/SharedPreferencesService.dart';
import '../helper/loading.dart';
import '../screens/Home/home_screen.dart';
import 'DatabaseService.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // login
  Future loginWithUserNameAndPassword(String email, String password) async {
    LoadingUtils.showLoader();
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      QuerySnapshot snapshot = await DatabaseService().gettingUserData(email);
      // saving the values to our shared preferences
      await SharedPreferencesService.saveUserLoggedInStatus(true);
      await SharedPreferencesService.saveUserEmailSF(email);
      await SharedPreferencesService.saveUserProfilePicSF(
          snapshot.docs[0]['profilePic']);
      await SharedPreferencesService.saveUserNameSF(
          snapshot.docs[0]['fullName']);
      await SharedPreferencesService.saveUserIDSF(snapshot.docs[0]['uid']);
      LoadingUtils.hideLoader();
      return true;
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error Logging in!", e.toString());
      LoadingUtils.hideLoader();
      return e.message;
    }
  }

  // register
  Future registerUserWithEmailAndPassword(
      String fullName, String email, String password, String img) async {
    LoadingUtils.showLoader();
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
      LoadingUtils.hideLoader();
      return true;
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error Signing up!", e.toString());
      LoadingUtils.hideLoader();
      return e.message;
    }
  }

  // Sign in with Google
  Future<User?> signInWithGoogle() async {
    try {
      LoadingUtils.showLoader();
      // Trigger Google sign-in flow
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        // Obtain auth details from the request
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        // Create a new credential
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        // Sign in with credential
        final UserCredential userCredential = await firebaseAuth.signInWithCredential(credential);

        // Get user data
        final User? user = userCredential.user;

        if (user != null) {
          // Check if it's the user's first time signing up
          if (userCredential.additionalUserInfo?.isNewUser ?? false) {
            // Retrieve user information from Google sign-in response
            String fullName = user.displayName ?? "";
            String email = user.email ?? "";
            String img = user.photoURL ?? "";

            // Save user data to Firestore
            await DatabaseService().savingUserData(user.uid, fullName, email, img);

            // Save user login status and other data to SharedPreferences
            await SharedPreferencesService.saveUserLoggedInStatus(true);
            await SharedPreferencesService.saveUserEmailSF(email);
            await SharedPreferencesService.saveUserProfilePicSF(img);
            await SharedPreferencesService.saveUserNameSF(fullName);
            await SharedPreferencesService.saveUserIDSF(user.uid);

          }

          LoadingUtils.hideLoader();
          Get.to(const HomePage());
        }

        return user;
      } else {
        // Handle sign-in cancellation
        LoadingUtils.hideLoader();
        Get.snackbar("Error!", "Google sign-in cancelled");
        print("Google sign-in cancelled");
        return null;
      }
    } catch (e) {
      // Handle sign-in error
      LoadingUtils.hideLoader();
      Get.snackbar("Error signing in with Google!", "$e");
      print("Error signing in with Google: $e");
      return null;
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
        MaterialPageRoute(builder: (context) => const IntroScreen()),
        (route) => false,
      );
    } catch (e) {
      return null;
    }
  }
}
