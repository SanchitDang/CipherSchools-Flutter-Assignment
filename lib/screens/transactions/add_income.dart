import 'package:cipher_schools_flutter_assignment/common%20widgets/custom_dropdown.dart';
import 'package:cipher_schools_flutter_assignment/common%20widgets/custom_text_field.dart';
import 'package:cipher_schools_flutter_assignment/common%20widgets/login_button.dart';
import 'package:flutter/material.dart';

import '../../helper/SharedPreferencesService.dart';
import '../../service/DatabaseService.dart';

class AddIncome extends StatefulWidget {
  const AddIncome({super.key});

  @override
  _AddIncomeState createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  List<String> categoryList = ["Shopping", "Subscription", "Travel", "Food"];
  List<String> walletList = ["Cash", "UPI", "Credit Card"];

  String? selectedCategory;
  String? selectedWallet;

  TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff7B61FF),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: const Color(0xff7B61FF),
              height: MediaQuery.of(context).size.height,
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.keyboard_backspace,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const Text(
                      "Income",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.24,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 0, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "How much?",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0,8,6,0),
                          child: Text(
                            "₹",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: amountController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                              hintText: 'Enter amount',
                              hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 38,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.40,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(40.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 30, 15, 10),
                  child: Column(
                    children: [
                      CustomDropdown(
                        hint: "Category",
                        items: categoryList,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCategory = newValue;
                          });
                        },
                      ),
                      const SizedBox(height: 14),
                      CustomTextField(
                        hint: "Description",
                        controller: descriptionController,
                      ),
                      const SizedBox(height: 14),
                      CustomDropdown(
                          hint: "Wallet",
                          items: walletList,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedWallet = newValue;
                            });
                          }),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: loginButton(() async {
                          String? uid =
                              await SharedPreferencesService.getUserIDFromSF();
                          DatabaseService().addEntry(
                              uid ?? "",
                              'income',
                              selectedWallet!,
                              double.parse(amountController.text),
                              selectedCategory!,
                              descriptionController.text);
                        }, "Continue"),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
