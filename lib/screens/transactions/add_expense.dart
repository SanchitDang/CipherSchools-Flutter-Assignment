import 'package:cipher_schools_flutter_assignment/common%20widgets/custom_dropdown.dart';
import 'package:cipher_schools_flutter_assignment/common%20widgets/custom_text_field.dart';
import 'package:cipher_schools_flutter_assignment/common%20widgets/login_button.dart';
import 'package:cipher_schools_flutter_assignment/helper/SharedPreferencesService.dart';
import 'package:cipher_schools_flutter_assignment/service/DatabaseService.dart';
import 'package:flutter/material.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({Key? key}) : super(key: key);

  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  List<String> categoryList = ["Shopping", "Subscription", "Travel", "Food"];
  List<String> walletList = ["Cash", "UPI", "Credit Card"];

  String? selectedCategory;
  String? selectedWallet;

  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0077FF),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: const Color(0xFF0077FF),
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
                      "Expense",
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
              top: MediaQuery.of(context).size.height * 0.22,
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
                    TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixText: '₹ ',
                        prefixStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        hintText: 'Enter amount',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.35,
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
                            String? uid = await SharedPreferencesService
                                .getUserIDFromSF();
                            DatabaseService().addEntry(
                                uid ?? "",
                                selectedWallet!,
                                double.parse(amountController.text),
                                selectedCategory!,
                                descriptionController.text);
                          }, "Continue"))
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
