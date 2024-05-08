import 'package:cipher_schools_flutter_assignment/consts/colors.dart';
import 'package:flutter/material.dart';

Widget incomeExpense(Color color, String title, String img, int income) {
  return Container(
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(20),
    ),
    padding: const EdgeInsets.all(16),
    child: Row(
      children: [
        Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image(
              image: AssetImage(img),
            ),
          ),
        ),

        const SizedBox(
            width: 8), // Add spacing between the CircleAvatar and Column
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14, color: whiteColor),
            ),
             Text(
              "₹ $income",
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 24, color: whiteColor),
            ),
          ],
        ),
      ],
    ),
  );
}
