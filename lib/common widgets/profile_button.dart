// ignore_for_file: file_names

import 'package:cipher_schools_flutter_assignment/consts/colors.dart';
import 'package:cipher_schools_flutter_assignment/consts/styles.dart';
import 'package:flutter/material.dart';

Widget profileButton(Color? icColor, String? title, String? img) {
  return Container(
    decoration: const BoxDecoration(
        color: whiteColor, borderRadius: BorderRadius.all(Radius.circular(10))),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                // color: Color(0xffEEE5FF),
                color: icColor!,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            height: 70,
            width: 70,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                img!,
                width: 20,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title!,
            style: const TextStyle(fontSize: 18, fontFamily: bold),
          )
        ],
      ),
    ),
  );
}
