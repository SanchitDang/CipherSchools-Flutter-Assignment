import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

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
  Future<void> addEntry(String userId, String type, double amount,
      String category, String description) async {
    try {
      // Get reference to Firestore collection
      CollectionReference entries = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('entries');

      // Add entry to Firestore
      await entries.add({
        'type': type,
        'amount': amount,
        'category': category,
        'description': description,
        'timestamp': DateTime.now(),
      });
    } catch (e) {
      print("Error adding entry: $e");
    }
  }

  // Function to delete an expense entry
  Future<void> deleteEntry(String userId, String entryId) async {
    try {
      // Get reference to Firestore document
      DocumentReference entryRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('entries')
          .doc(entryId);

      // Delete entry from Firestore
      await entryRef.delete();
    } catch (e) {
      print("Error deleting entry: $e");
    }
  }

  // Function to fetch both income and expenses
  Future<List<DocumentSnapshot>> fetchEntries(String userId) async {
    try {
      // Get reference to Firestore collection for entries
      CollectionReference entriesRef = FirebaseFirestore.instance.collection('users').doc(userId).collection('entries');

      // Fetch snapshots for entries
      QuerySnapshot snapshot = await entriesRef.orderBy('timestamp', descending: true).get();

      // Return list of document snapshots
      return snapshot.docs;
    } catch (e) {
      print("Error fetching entries: $e");
      throw e;
    }
  }


  // Function to add expense or income entry
  Future<void> addIncome(String userId, String type, double amount,
      String category, String description) async {
    try {
      // Get reference to Firestore collection
      CollectionReference entries = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('income');

      // Add entry to Firestore
      await entries.add({
        'type': type,
        'amount': amount,
        'category': category,
        'description': description,
        'timestamp': DateTime.now(),
      });
    } catch (e) {
      print("Error adding icomme: $e");
    }
  }

  // Function to delete an expense entry
  Future<void> deleteIncome(String userId, String entryId) async {
    try {
      // Get reference to Firestore document
      DocumentReference entryRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('income')
          .doc(entryId);

      // Delete entry from Firestore
      await entryRef.delete();
    } catch (e) {
      print("Error delete income: $e");
    }
  }

  // Function to fetch income snapshots
  Future<List<DocumentSnapshot>> fetchIncome(String userId) async {
    try {
      // Get reference to Firestore collection
      CollectionReference entries = FirebaseFirestore.instance.collection('users').doc(userId).collection('income');

      // Fetch snapshots
      QuerySnapshot snapshot = await entries.orderBy('timestamp', descending: true).get();

      // Return list of document snapshots
      return snapshot.docs;
    } catch (e) {
      print("Error fetching income: $e");
      throw e;
    }
  }

  // Function to fetch both income and expenses
  Future<List<DocumentSnapshot>> fetchIncomeAndExpenses(String userId) async {
    try {
      // Get reference to Firestore collections for income and expenses
      CollectionReference expensesRef = FirebaseFirestore.instance.collection('users').doc(userId).collection('entries');
      CollectionReference incomeRef = FirebaseFirestore.instance.collection('users').doc(userId).collection('income');

      // Fetch snapshots for expenses and income
      QuerySnapshot expensesSnapshot = await expensesRef.get();
      QuerySnapshot incomeSnapshot = await incomeRef.get();

      // Combine snapshots of income and expenses
      List<DocumentSnapshot> combined = [];
      combined.addAll(expensesSnapshot.docs);
      combined.addAll(incomeSnapshot.docs);
      combined.sort((a, b) => (b['timestamp'] as Timestamp).compareTo(a['timestamp'] as Timestamp)); // Sort by timestamp

      return combined;
    } catch (e) {
      print("Error fetching income and expenses: $e");
      throw e;
    }
  }


}
