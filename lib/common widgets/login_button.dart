import 'package:cipher_schools_flutter_assignment/consts/colors.dart';
import 'package:cipher_schools_flutter_assignment/consts/styles.dart';
import 'package:flutter/material.dart';

Widget loginButton(onPress, String? title) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          backgroundColor: const Color(0xff7F3DFF),
          padding: const EdgeInsets.all(12)),
      onPressed: onPress,
      child: Text(
        title!,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ));
}

Widget googleButton(String? login) {
  return SizedBox(
    height: 60,
    width: 350,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          backgroundColor: whiteColor,
          padding: const EdgeInsets.all(12)),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage('images/google_logo.png'),
            width: 26,
            height: 26,
          ),
          const SizedBox(width: 12,),
          Text(
            login!,
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),

        ],
      ),
    ),
  );
}
