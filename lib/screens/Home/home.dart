import 'package:cipher_schools_flutter_assignment/common%20widgets/exp_inc.dart';
import 'package:cipher_schools_flutter_assignment/common%20widgets/transaction_widget.dart';
import 'package:cipher_schools_flutter_assignment/consts/styles.dart';
import 'package:cipher_schools_flutter_assignment/controller/home_controller.dart';
import 'package:cipher_schools_flutter_assignment/controller/home_page_controller.dart';
import 'package:cipher_schools_flutter_assignment/helper/date_time.dart';
import 'package:cipher_schools_flutter_assignment/service/DatabaseService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts/colors.dart';
import '../../consts/constants.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final navButtonController = Get.put(ButtonController());
    HomePageController controller = Get.put(HomePageController());

    var media = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFFF8EDD8).withOpacity(0.6),
                      const Color(0xFFFFF6E5).withOpacity(0.6),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(
                                    0xff803efa), // Purple color border
                                width: 2, // Border width
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.transparent,
                                child: Image.asset(
                                  'images/profile.png',
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  20), // Adjust the radius as needed
                              border: Border.all(
                                color: primaryColor
                                    .withOpacity(0.5), // Light purple color
                                width: 0.8, // Border width
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  color: primaryColor,
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Obx(() => DropdownButton(
                                      isExpanded: false,
                                      value: controller.selectedMonth.value,
                                      icon: const SizedBox(),
                                      style:
                                          const TextStyle(color: Colors.black),
                                      underline:
                                          const SizedBox(), // Remove the underline
                                      onChanged: (String? newValue) {
                                        controller.changeMonth(newValue!);
                                      },
                                      items: months
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    )),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.notifications,
                              size: 38,
                              color: primaryColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Account Balance",
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Semibold',
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() => Text(
                          "₹ ${controller.accBalance.value}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 40,
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            incomeExpense(
                                const Color(0xff00A86B),
                                "Income",
                                'images/income.png',
                                controller.accIncome.value),
                            incomeExpense(
                                const Color(0xffFD3C4A),
                                "Expenses",
                                'images/Expense.png',
                                controller.accExpense.value),
                          ],
                        )),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Recent Transactions",
                      style: TextStyle(fontSize: 20, fontFamily: bold),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xffEEE5FF)),
                      ),
                      onPressed: () {
                        HomeController controller = Get.find();
                        controller.currentNavIndex.value = 1;
                      },
                      child: const Text(
                        " See All ",
                        style: TextStyle(color: Color(0xff7F3DFF)),
                      ),
                    )
                  ],
                ),
              ),
              Obx(() => FutureBuilder<List<DocumentSnapshot>>(
                    future: DatabaseService().fetchIncomeAndExpenses(
                        controller.selectedFilter.value),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator(
                                color: Color(0xff7F3DFF)));
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
                            String time = DateTimeHelper.formattedTimestamp(
                                entries[index]['timestamp']);
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
                            return transaction(docId, type, image, category,
                                amount, description, time);
                          },
                        );
                      }
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
