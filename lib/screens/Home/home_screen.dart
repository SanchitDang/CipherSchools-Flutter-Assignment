import 'package:cipher_schools_flutter_assignment/consts/colors.dart';
import 'package:cipher_schools_flutter_assignment/consts/styles.dart';
import 'package:cipher_schools_flutter_assignment/controller/home_controller.dart';
import 'package:cipher_schools_flutter_assignment/screens/Home/home.dart';
import 'package:cipher_schools_flutter_assignment/screens/budget/budget_screen.dart';
import 'package:cipher_schools_flutter_assignment/screens/profile/profile_screen.dart';
import 'package:cipher_schools_flutter_assignment/screens/transactions/add_expense.dart';
import 'package:cipher_schools_flutter_assignment/screens/transactions/add_income.dart';
import 'package:cipher_schools_flutter_assignment/screens/transactions/transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    var navBody = [
      Home(),
      const TransactionScreen(),
      const BudgetScreen(),
      const ProfileScreen()
    ];
    return Scaffold(
      body: Center(
          child:
              Obx(() => navBody.elementAt(controller.currentNavIndex.value))),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentNavIndex.value,
          selectedItemColor: primaryColor,
          selectedIconTheme: const IconThemeData(color: primaryColor),
          selectedLabelStyle: const TextStyle(fontFamily: semibold),
          items: [
            BottomNavigationBarItem(
                icon: Image.asset(
                  'images/home.png',
                  width: 26,
                  color: controller.currentNavIndex.value == 0
                      ? primaryColor
                      : null,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Image.asset(
                  'images/transaction.png',
                  width: 26,
                  color: controller.currentNavIndex.value == 1
                      ? primaryColor
                      : null,
                ),
                label: "Transactions"),
            BottomNavigationBarItem(
                icon: Image.asset(
                  'images/pie-chart.png',
                  width: 26,
                  color: controller.currentNavIndex.value == 2
                      ? primaryColor
                      : null,
                ),
                label: "Budget"),
            BottomNavigationBarItem(
                icon: Image.asset(
                  'images/user.png',
                  width: 26,
                  color: controller.currentNavIndex.value == 3
                      ? primaryColor
                      : null,
                ),
                label: "Profile"),
          ],
          type: BottomNavigationBarType.fixed,
          backgroundColor: whiteColor,
          onTap: (value) {
            controller.currentNavIndex.value = value;
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openAddBottomSheet(context),
        shape: const CircleBorder(),
        backgroundColor: primaryColor,
        child: const Icon(
          Icons.add,
          size: 40.0,
          color: whiteColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  static Future<dynamic> openAddBottomSheet(BuildContext context) {
    return Get.bottomSheet(
      elevation: 10,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.80),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.36,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Add a Track",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Add an Expense ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                      ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Color(0xffFD3C4A))),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Get.to(const AddExpense());
                        },
                        child: const Text(
                          '+ Expense',
                          style: TextStyle(color: whiteColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Add an Income ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                      ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Color(0xff00A86B))),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Get.to(const AddIncome());
                        },
                        child: const Text(
                          ' + Income ',
                          style: TextStyle(color: whiteColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              const Text(
                "Tracking expenses is key to financial awareness. It helps you understand your spending habits and make smarter choices with your money.",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
