import 'package:flutter/material.dart';
import 'package:cipher_schools_flutter_assignment/consts/colors.dart';
import 'package:cipher_schools_flutter_assignment/consts/styles.dart';

Widget transaction(
    String? img, String? title, String? amount, String? prupose) {
  return Dismissible(
    key: UniqueKey(),
    background: Container(
      color: Colors.red,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    ),
    onDismissed: (direction) {
      // Implement delete logic here
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
            height: 60,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xfffaefd2),
            ),
            child: Image(
              image: AssetImage(img!),
              height: 30,
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title!,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.black),
              ),
              const SizedBox(height: 4),
              Text(
                prupose!,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: fontGrey),
              ),
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                amount!,
                style: const TextStyle(
                    color: Color(0xffFD3C4A),
                    fontFamily: bold,
                    fontSize: 16),
              ),
              const Text(
                "10:00 AM",
                style: TextStyle(color: fontGrey),
              )
            ],
          )
        ],
      ),
    ),
  );
}
