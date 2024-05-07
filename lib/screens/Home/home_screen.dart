import 'package:cipher_schools_flutter_assignment/consts/colors.dart';
import 'package:cipher_schools_flutter_assignment/consts/styles.dart';
import 'package:cipher_schools_flutter_assignment/controller/home_controller.dart';
import 'package:cipher_schools_flutter_assignment/screens/Home/home.dart';
import 'package:cipher_schools_flutter_assignment/screens/budget/budget_screen.dart';
import 'package:cipher_schools_flutter_assignment/screens/profile/profile_screen.dart';
import 'package:cipher_schools_flutter_assignment/screens/transactions/add_expense.dart';
import 'package:cipher_schools_flutter_assignment/screens/transactions/add_income.dart';
import 'package:cipher_schools_flutter_assignment/screens/transactions/transac_screen.dart';
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
      const Home(),
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
          selectedItemColor: const Color(0xff803efa),
          selectedIconTheme: const IconThemeData(color: Color(0xff803efa)),
          selectedLabelStyle: const TextStyle(fontFamily: semibold),
          items: [
            BottomNavigationBarItem(
                icon: Image.asset(
                  'images/home.png',
                  width: 26,
                  color: controller.currentNavIndex.value == 0
                      ? const Color(0xff803efa)
                      : null,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Image.asset(
                  'images/transaction.png',
                  width: 26,
                  color: controller.currentNavIndex.value == 1
                      ? const Color(0xff803efa)
                      : null,
                ),
                label: "Transactions"),
            BottomNavigationBarItem(
                icon: Image.asset(
                  'images/pie-chart.png',
                  width: 26,
                  color: controller.currentNavIndex.value == 2
                      ? const Color(0xff803efa)
                      : null,
                ),
                label: "Budget"),
            BottomNavigationBarItem(
                icon: Image.asset(
                  'images/user.png',
                  width: 26,
                  color: controller.currentNavIndex.value == 3
                      ? const Color(0xff803efa)
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
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Choose An Option'),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Color(0xffFD3C4A))),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Get.to(const AddExpense());
                      },
                      child: const Text(
                        'Expense',
                        style: TextStyle(color: whiteColor),
                      ),
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
                        'Income',
                        style: TextStyle(color: whiteColor),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        shape: const CircleBorder(),
        backgroundColor: const Color(0xff803efa),
        child: const Icon(
          Icons.add,
          size: 40.0,
          color: whiteColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
