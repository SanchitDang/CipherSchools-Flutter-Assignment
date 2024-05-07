import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../common widgets/transaction_widget.dart';
import '../../service/DatabaseService.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions"),
        centerTitle: true,
        leading: const SizedBox(),
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            FutureBuilder<List<DocumentSnapshot>>(
              future: DatabaseService().fetchIncomeAndExpenses(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child:
                          CircularProgressIndicator(color: Color(0xff7F3DFF)));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<DocumentSnapshot<Object?>> entries =
                      (snapshot.data as List<DocumentSnapshot<Object?>>);

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: entries.length,
                    itemBuilder: (BuildContext context, int index) {
                      String docId = entries[index]['uid'];
                      String category = entries[index]['category'];
                      String amount =
                          entries[index]['amount'].toStringAsFixed(2);
                      String type = entries[index]['type'];
                      String time =
                          formattedTimestamp(entries[index]['timestamp']);
                      String description = entries[index]['description'];
                      String image = '';
                      if (category == "Shopping") {
                        image = 'images/shopping.png';
                      } else if (category == "Subscription") {
                        image = 'images/bill.png';
                      } else if (category == "Travel") {
                        image = 'images/car.png';
                      } else if (category == "Food") {
                        image = 'images/restaurant.png';
                      }
                      return transaction(docId, type, image, category, amount,
                          description, time);
                    },
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  String formattedTimestamp(Timestamp timestamp) {
    DateTime dateTime =
        timestamp.toDate(); // Convert Firestore Timestamp to DateTime
    return DateFormat('h:mm a').format(dateTime); // Format DateTime object
  }
}
