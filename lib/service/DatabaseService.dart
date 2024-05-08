import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:get/get.dart';
import '../controller/home_page_controller.dart';
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
  // Future<List<DocumentSnapshot>> fetchIncomeAndExpenses(String duration) async {
  //   try {
  //     if (duration == "today") {
  //       // show where field named timestamp having today date
  //     } else if (duration == "week") {
  //       // show data of this week
  //     } else if (duration == "month") {
  //       //  show data of this month
  //     } else if (duration == "year") {
  //       //  show data of this year
  //     }
  //
  //     String userId = await SharedPreferencesService.getUserIDFromSF() ?? "";
  //
  //     // Get reference to Firestore collections for income and expenses
  //     CollectionReference expensesRef = FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(userId)
  //         .collection('expense');
  //     CollectionReference incomeRef = FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(userId)
  //         .collection('income');
  //
  //     // Fetch snapshots for expenses and income
  //     QuerySnapshot expensesSnapshot = await expensesRef.get();
  //     QuerySnapshot incomeSnapshot = await incomeRef.get();
  //
  //     // Combine snapshots of income and expenses
  //     List<DocumentSnapshot> combined = [];
  //     combined.addAll(expensesSnapshot.docs);
  //     combined.addAll(incomeSnapshot.docs);
  //     combined.sort((a, b) => (b['timestamp'] as Timestamp)
  //         .compareTo(a['timestamp'] as Timestamp)); // Sort by timestamp
  //
  //     HomePageController homePageController = Get.find();
  //
  //     // Calculate sum of income and expenses
  //     double totalIncome = 0;
  //     double totalExpense = 0;
  //     for (var doc in combined) {
  //       if (doc['type'] == 'income') {
  //         totalIncome += (doc['amount'] ?? 0).toDouble();
  //       } else if (doc['type'] == 'expense') {
  //         totalExpense += (doc['amount'] ?? 0).toDouble();
  //       }
  //     }
  //
  //     // Calculate amount balance
  //     double amountBalance = totalIncome - totalExpense;
  //
  //     homePageController.changeAccBalance(amountBalance);
  //     homePageController.changeAccIncome(totalIncome);
  //     homePageController.changeAccExpense(totalExpense);
  //
  //     return combined;
  //   } catch (e) {
  //     print("Error fetching income and expenses: $e");
  //     throw e;
  //   }
  // }

  Future<List<DocumentSnapshot>> fetchIncomeAndExpenses(String duration) async {
    try {
      DateTime now = DateTime.now();
      DateTime? startDateTime;
      DateTime? endDateTime;

      // Calculate start and end date based on the selected duration
      if (duration == "today") {
        startDateTime = DateTime(now.year, now.month, now.day);
        endDateTime = DateTime(now.year, now.month, now.day, 23, 59, 59);
      } else if (duration == "week") {
        // Calculate start date of the week (Monday)
        startDateTime = now.subtract(Duration(days: now.weekday - 1));
        // Calculate end date of the week (Sunday)
        endDateTime =
            now.add(Duration(days: DateTime.daysPerWeek - now.weekday));
      } else if (duration == "month") {
        startDateTime = DateTime(now.year, now.month, 1);
        endDateTime = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
      } else if (duration == "year") {
        startDateTime = DateTime(now.year, 1, 1);
        endDateTime = DateTime(now.year, 12, 31, 23, 59, 59);
      }

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

      // Query expenses and income based on the selected duration
      QuerySnapshot expensesSnapshot = await expensesRef
          .where('timestamp', isGreaterThanOrEqualTo: startDateTime)
          .where('timestamp', isLessThanOrEqualTo: endDateTime)
          .get();
      QuerySnapshot incomeSnapshot = await incomeRef
          .where('timestamp', isGreaterThanOrEqualTo: startDateTime)
          .where('timestamp', isLessThanOrEqualTo: endDateTime)
          .get();

      // Combine snapshots of income and expenses
      List<DocumentSnapshot> combined = [];
      combined.addAll(expensesSnapshot.docs);
      combined.addAll(incomeSnapshot.docs);
      combined.sort((a, b) => (b['timestamp'] as Timestamp)
          .compareTo(a['timestamp'] as Timestamp)); // Sort by timestamp

      HomePageController homePageController = Get.find();

      // Calculate sum of income and expenses
      double totalIncome = 0;
      double totalExpense = 0;
      for (var doc in combined) {
        if (doc['type'] == 'income') {
          totalIncome += (doc['amount'] ?? 0).toDouble();
        } else if (doc['type'] == 'expense') {
          totalExpense += (doc['amount'] ?? 0).toDouble();
        }
      }

      // Calculate amount balance
      double amountBalance = totalIncome - totalExpense;

      // Update the controller with new data
      homePageController.changeAccBalance(amountBalance);
      homePageController.changeAccIncome(totalIncome);
      homePageController.changeAccExpense(totalExpense);

      return combined;
    } catch (e) {
      print("Error fetching income and expenses: $e");
      throw e;
    }
  }

  // Check if user exists in Firestore
  Future<bool> checkUserExists(String userId) async {
    try {
      DocumentSnapshot userSnapshot = await userCollection.doc(userId).get();
      return userSnapshot.exists;
    } catch (e) {
      print("Error checking user existence: $e");
      return false;
    }
  }
}
