import 'package:cipher_schools_flutter_assignment/common%20widgets/exp_inc.dart';
import 'package:cipher_schools_flutter_assignment/common%20widgets/transac_widget.dart';
import 'package:cipher_schools_flutter_assignment/consts/styles.dart';
import 'package:cipher_schools_flutter_assignment/controller/home_controller.dart';
import 'package:cipher_schools_flutter_assignment/helper/SharedPreferencesService.dart';
import 'package:cipher_schools_flutter_assignment/service/DatabaseService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controller = Get.put(ButtonController());
  String uid ="";
  String selectedMonth = 'January'; // Initial value
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  void getID() async {
    uid = await SharedPreferencesService.getUserIDFromSF() ?? "";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getID();
  }
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFFF6E5),
                    Color(0xFFF8EDD8),
                  ],
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CircleAvatar(
                          backgroundColor: const Color(0xff803efa),
                          child: Image.asset('images/profile_image.png', height: 150,),
                        ),
                      ),
                      DropdownButton(
                        value: selectedMonth,
                        icon: const Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: Color(0xff803efa),
                        ),
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        iconSize: 24,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedMonth = newValue!;
                          });
                        },
                        items: months.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications,
                          size: 36,
                          color: Color(0xff803efa),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10,),
                  const Text(
                    "Account Balance",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Semibold',
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text(
                    "₹38000",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Bold',
                      fontSize: 38,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      incomeExpense(const Color(0xff00A86B), "Income", 'images/income.png'),
                      incomeExpense(const Color(0xffFD3C4A), "Expense", 'images/Expense.png'),
                    ],
                  ),
                  const SizedBox(height: 25,),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => _controller.changeIndex(0),
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    width: media.width * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(20),
                        right: Radius.circular(20),
                      ),
                      color: _controller.selectedIndex.value == 0
                          ? const Color(0xffffceed4)
                          : Theme.of(context)
                          .colorScheme
                          .surface
                          .withOpacity(0.9),
                    ),
                    child: Text(
                      'Today',
                      style: TextStyle(
                          color: _controller.selectedIndex.value == 0
                              ? const Color(0xFFFCAC12)
                              : Colors.grey,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => _controller.changeIndex(1),
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    width: media.width * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(20),
                        right: Radius.circular(20),
                      ),
                      color: _controller.selectedIndex.value == 1
                          ? const Color(0xffffceed4)
                          : Theme.of(context)
                          .colorScheme
                          .surface
                          .withOpacity(0.9),
                    ),
                    child: Text(
                      'Week',
                      style: TextStyle(
                          color: _controller.selectedIndex.value == 1
                              ? const Color(0xFFFCAC12)
                              : Colors.grey,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => _controller.changeIndex(2),
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    width: media.width * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(20),
                        right: Radius.circular(20),
                      ),
                      color: _controller.selectedIndex.value == 2
                          ? const Color(0xffffceed4)
                          : Theme.of(context)
                          .colorScheme
                          .surface
                          .withOpacity(0.9),
                    ),
                    child: Text(
                      'Month',
                      style: TextStyle(
                          color: _controller.selectedIndex.value == 2
                              ? const Color(0xFFFCAC12)
                              : Colors.grey,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => _controller.changeIndex(3),
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    width: media.width * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(20),
                        right: Radius.circular(20),
                      ),
                      color: _controller.selectedIndex.value == 3
                          ? const Color(0xffffceed4)
                          : Theme.of(context)
                          .colorScheme
                          .surface
                          .withOpacity(0.9),
                    ),
                    child: Text(
                      'Year',
                      style: TextStyle(
                          color: _controller.selectedIndex.value == 3
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
                    onPressed: () {},
                    child: const Text(
                      "See All",
                      style: TextStyle(color: Color(0xff7F3DFF)),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<DocumentSnapshot>>(
                future: DatabaseService().fetchIncomeAndExpenses(uid), // Assuming userId is available in your scope
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    List<DocumentSnapshot<Object?>> entries = (snapshot.data as List<DocumentSnapshot<Object?>>);

                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: List.generate(entries.length, (index) {
                          String category = entries[index]['category'];
                          String amount = entries[index]['amount'].toStringAsFixed(2);
                          String type = entries[index]['type'] == 'income' ? '+₹$amount' : '-₹$amount';
                          String description = entries[index]['description'];
                          String image = ''; // Add logic to get image path based on category
                          return transaction(image, category, type, description);
                        }),
                      ),
                    );
                  }
                },
              ),
            )

          ],
        ),
      ),
    );
  }
}
