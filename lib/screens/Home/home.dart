import 'package:cipher_schools_flutter_assignment/common%20widgets/exp_inc.dart';
import 'package:cipher_schools_flutter_assignment/common%20widgets/transaction_widget.dart';
import 'package:cipher_schools_flutter_assignment/consts/styles.dart';
import 'package:cipher_schools_flutter_assignment/controller/home_controller.dart';
import 'package:cipher_schools_flutter_assignment/service/DatabaseService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controller = Get.put(ButtonController());
  String selectedMonth = 'January';
  int accBalance = 38000;
  int accIncome = 38000;
  int accExpense = 38000;
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

  void setData() async {
    selectedMonth = DateFormat('MMMM').format(DateTime.now());
  }

  @override
  void initState() {
    super.initState();
    setData();
  }

  @override
  Widget build(BuildContext context) {
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
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.transparent,
                              child: Image.asset(
                                'images/user.png',
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  20), // Adjust the radius as needed
                              border: Border.all(
                                color: const Color(0xff803efa)
                                    .withOpacity(0.5), // Light purple color
                                width: 0.8, // Border width
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  color: Color(0xff803efa),
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                DropdownButton(
                                  isExpanded: false,
                                  value: selectedMonth,
                                  icon: const SizedBox(),
                                  style: const TextStyle(color: Colors.black),
                                  underline:
                                      const SizedBox(), // Remove the underline
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedMonth = newValue!;
                                    });
                                  },
                                  items: months.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.notifications,
                              size: 38,
                              color: Color(0xff803efa),
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
                    Text(
                      "₹ $accBalance",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 40,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        incomeExpense(const Color(0xff00A86B), "Income",
                            'images/income.png', accIncome),
                        incomeExpense(const Color(0xffFD3C4A), "Expenses",
                            'images/Expense.png', accExpense),
                      ],
                    ),
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
                      GestureDetector(
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
                      GestureDetector(
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
                      GestureDetector(
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
                                ? const Color(0xFFFCEED4)
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
              FutureBuilder<List<DocumentSnapshot>>(
                future: DatabaseService().fetchIncomeAndExpenses(),
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
      ),
    );
  }

  String formattedTimestamp(Timestamp timestamp) {
    DateTime dateTime =
        timestamp.toDate(); // Convert Firestore Timestamp to DateTime
    return DateFormat('h:mm a').format(dateTime); // Format DateTime object
  }
}
