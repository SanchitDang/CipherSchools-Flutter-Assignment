// ignore_for_file: file_names

import 'package:cipher_schools_flutter_assignment/consts/colors.dart';
import 'package:cipher_schools_flutter_assignment/consts/styles.dart';
import 'package:flutter/material.dart';

Widget profileButton(Color? icColor, String? title, String? img) {
  return Container(
    decoration: const BoxDecoration(
        color: whiteColor, borderRadius: BorderRadius.all(Radius.circular(10))),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
      child: Row(
        children: [
          Container(
            height: 64,
            width: 64,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
                color: icColor!,
                borderRadius: const BorderRadius.all(Radius.circular(18))),
            child: SizedBox(
              child: Image(
                image: AssetImage(img!),
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(
            width: 14,
          ),
          Text(
            title!,
            style: const TextStyle(fontSize: 18),
          )
        ],
      ),
    ),
  );
}
