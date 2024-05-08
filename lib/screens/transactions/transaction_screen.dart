import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../common widgets/transaction_widget.dart';
import '../../controller/home_controller.dart';
import '../../controller/home_page_controller.dart';
import '../../service/DatabaseService.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomePageController controller = Get.find();
    final navButtonController = Get.put(ButtonController());
    var media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions"),
        centerTitle: true,
        leading: const SizedBox(),
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.selectedFilter('today');
                    navButtonController.changeIndex(0);
                  },
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    width: media.width * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(20),
                        right: Radius.circular(20),
                      ),
                      color: navButtonController.selectedIndex.value == 0
                          ? const Color(0xfffceed4)
                          : Theme.of(context)
                          .colorScheme
                          .surface
                          .withOpacity(0.9),
                    ),
                    child: Text(
                      'Today',
                      style: TextStyle(
                          color:
                          navButtonController.selectedIndex.value == 0
                              ? const Color(0xFFFCAC12)
                              : Colors.grey,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.selectedFilter('week');
                    navButtonController.changeIndex(1);
                  },
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    width: media.width * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(20),
                        right: Radius.circular(20),
                      ),
                      color: navButtonController.selectedIndex.value == 1
                          ? const Color(0xfffceed4)
                          : Theme.of(context)
                          .colorScheme
                          .surface
                          .withOpacity(0.9),
                    ),
                    child: Text(
                      'Week',
                      style: TextStyle(
                          color:
                          navButtonController.selectedIndex.value == 1
                              ? const Color(0xFFFCAC12)
                              : Colors.grey,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.selectedFilter('month');
                    navButtonController.changeIndex(2);
                  },
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    width: media.width * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(20),
                        right: Radius.circular(20),
                      ),
                      color: navButtonController.selectedIndex.value == 2
                          ? const Color(0xfffceed4)
                          : Theme.of(context)
                          .colorScheme
                          .surface
                          .withOpacity(0.9),
                    ),
                    child: Text(
                      'Month',
                      style: TextStyle(
                          color:
                          navButtonController.selectedIndex.value == 2
                              ? const Color(0xFFFCAC12)
                              : Colors.grey,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.selectedFilter('year');
                    navButtonController.changeIndex(3);
                  },
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    width: media.width * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(20),
                        right: Radius.circular(20),
                      ),
                      color: navButtonController.selectedIndex.value == 3
                          ? const Color(0xFFFCEED4)
                          : Theme.of(context)
                          .colorScheme
                          .surface
                          .withOpacity(0.9),
                    ),
                    child: Text(
                      'Year',
                      style: TextStyle(
                          color:
                          navButtonController.selectedIndex.value == 3
                              ? const Color(0xFFFCAC12)
                              : Colors.grey,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            )),
            Obx(() => FutureBuilder<List<DocumentSnapshot>>(
              future: DatabaseService().fetchIncomeAndExpenses(controller.selectedFilter.value),
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
            ))
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
