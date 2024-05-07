import 'package:cipher_schools_flutter_assignment/helper/SharedPreferencesService.dart';
import 'package:cipher_schools_flutter_assignment/service/DatabaseService.dart';
import 'package:flutter/material.dart';
import 'package:cipher_schools_flutter_assignment/consts/colors.dart';
import 'package:cipher_schools_flutter_assignment/consts/styles.dart';

Widget transaction(String entryId, String type, String? img, String? title,
    String? amount, String? description, String time) {
  return Dismissible(
    key: UniqueKey(),
    secondaryBackground: Container(
      color: Colors.red,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(right: 20.0),
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
    ),
    background: Container(
      color: Colors.green,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(left: 20.0),
      child: const Icon(
        Icons.edit,
        color: Colors.white,
      ),
    ),
    onDismissed: (direction) async {
      String userId = await SharedPreferencesService.getUserIDFromSF() ?? "";
      if (direction == DismissDirection.endToStart) {
        DatabaseService().deleteEntry(userId, type, entryId);
      } else if (direction == DismissDirection.startToEnd) {
        print("EDIT ");
      }
    },
    child: Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xfffcfcfc),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            height: 70,
            width: 70,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(18),
              color: title == 'Shopping'
                  ? const Color(0xfffaefd2)
                  : title == 'Subscription'
                  ? const Color(0xffEEE5FF)
                  : title == 'Travel'
                  ? const Color(0xffF1F1FA)
                  : const Color(0xffFDD5D7),
            ),
            child: SizedBox(
              child: Image(
                image: AssetImage(img!),
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title!,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black),
              ),
              const SizedBox(height: 4),
              Text(
                description!,
                style: const TextStyle(
                    fontSize: 14,
                    color: fontGrey),
              ),
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                type == 'income' ? '+₹$amount' : '-₹$amount',
                style: TextStyle(
                    color: type == 'expense'
                        ? const Color(0xffFD3C4A)
                        : const Color(0xff00A86B),
                    fontFamily: bold,
                    fontSize: 16),
              ),
              Text(
                time,
                style: const TextStyle(color: fontGrey),
              )
            ],
          )
        ],
      ),
    ),
  );
}
