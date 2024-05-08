import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:get/get.dart';
import '../helper/SharedPreferencesService.dart';
import '../helper/loading.dart';

class DatabaseService {

  // reference for our collections
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  // saving the userdata
  Future savingUserData(
      String userId, String fullName, String email, String img) async {
    return await userCollection.doc(userId).set({
      "fullName": fullName,
      "email": email,
      "profilePic": img,
      "uid": userId,
    });
  }

  // getting user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  // Function to add expense or income entry
  Future<void> addEntry(String userId, String type, String paymentMethod,
      double amount, String category, String description) async {
    try {
    LoadingUtils.showLoader();
      // Get reference to Firestore collection
      CollectionReference entries = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection(type);

      // Add entry to Firestore
      DocumentReference entryRef = await entries.add({
        'type': type,
        'payment_method': paymentMethod,
        'amount': amount,
        'category': category,
        'description': description,
        'timestamp': DateTime.now(),
      });

      // Update the added entry with its document ID (UID)
      await entryRef.update({'uid': entryRef.id});
      LoadingUtils.hideLoader();
      Get.snackbar("Hurray!", "Entry Added Successfully.");
    } catch (e) {
      LoadingUtils.hideLoader();
      Get.snackbar("Error!", e.toString());
      print("Error adding entry: $e");
    }
  }

  // Function to delete an expense entry
  Future<void> deleteEntry(String userId, String type, String entryId) async {
    try {
    LoadingUtils.showLoader();
      // Get reference to Firestore document
      DocumentReference entryRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection(type)
          .doc(entryId);

      // Delete entry from Firestore

    LoadingUtils.hideLoader();
      Get.snackbar("Hurray!", "Entry Deleted Successfully.");
      await entryRef.delete();
    } catch (e) {

      LoadingUtils.hideLoader();
      Get.snackbar("Error!", e.toString());
      print("Error deleting entry: $e");
    }
  }

  // Function to fetch both income and expenses
  Future<List<DocumentSnapshot>> fetchEntry(String userId, String type) async {
    try {
      // Get reference to Firestore collection for entries
      CollectionReference entriesRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection(type);

      // Fetch snapshots for entries
      QuerySnapshot snapshot =
          await entriesRef.orderBy('timestamp', descending: true).get();

      // Return list of document snapshots
      return snapshot.docs;
    } catch (e) {
      print("Error fetching entries: $e");
      throw e;
    }
  }

  // Function to fetch both income and expenses
  Future<List<DocumentSnapshot>> fetchIncomeAndExpenses() async {
    try {
      String userId = await SharedPreferencesService.getUserIDFromSF() ?? "";

      // Get reference to Firestore collections for income and expenses
      CollectionReference expensesRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('expense');
      CollectionReference incomeRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('income');

      // Fetch snapshots for expenses and income
      QuerySnapshot expensesSnapshot = await expensesRef.get();
      QuerySnapshot incomeSnapshot = await incomeRef.get();

      // Combine snapshots of income and expenses
      List<DocumentSnapshot> combined = [];
      combined.addAll(expensesSnapshot.docs);
      combined.addAll(incomeSnapshot.docs);
      combined.sort((a, b) => (b['timestamp'] as Timestamp)
          .compareTo(a['timestamp'] as Timestamp)); // Sort by timestamp

      return combined;
    } catch (e) {
      print("Error fetching income and expenses: $e");
      throw e;
    }
  }

  // Check if user exists in Firestore
  Future<bool> checkUserExists(String userId) async {
    try {
      DocumentSnapshot userSnapshot =
      await userCollection.doc(userId).get();
      return userSnapshot.exists;
    } catch (e) {
      print("Error checking user existence: $e");
      return false;
    }
  }
}
