import 'package:cipher_schools_flutter_assignment/consts/colors.dart';
import 'package:flutter/material.dart';

Widget incomeExpense(Color color, String title, String img) {
  return Container(
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(15),
    ),
    padding: const EdgeInsets.all(16),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: CircleAvatar(
            radius: 17,
            backgroundColor: Colors.white,
            child: Image(
              image: AssetImage(img),
              height: 40,
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
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 14, color: whiteColor),
            ),
            const Text(
              "₹50000",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 24, color: whiteColor),
            ),
          ],
        ),
      ],
    ),
  );
}
