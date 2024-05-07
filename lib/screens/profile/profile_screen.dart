import 'package:cipher_schools_flutter_assignment/common%20widgets/profile_button.dart';
import 'package:cipher_schools_flutter_assignment/consts/colors.dart';
import 'package:cipher_schools_flutter_assignment/consts/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cipher_schools_flutter_assignment/service/AuthService.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xff803efa), // Purple color border
                      width: 2, // Border width
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.transparent,
                    child: Image.asset(
                      'images/user.png',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Username",
                        style: TextStyle(color: fontGrey, fontSize: 14),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "Khushi Sharwaefawefawefawefawfema",
                        style: TextStyle(fontSize: 26, fontFamily: bold),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.mode_edit_outlined,
                      size: 30,
                    ))
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Card(
              color: whiteColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    26), // Adjust the border radius as needed
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 14,
                  ),
                  profileButton(
                      const Color(0xffEEE5FF), "Account", "images/Wallet.png"),
                  Divider(color: Colors.grey.withOpacity(0.2),),
                  profileButton(
                      const Color(0xffEEE5FF), "Settings", "images/Wallet.png"),
                  Divider(color: Colors.grey.withOpacity(0.2),),
                  profileButton(const Color(0xffEEE5FF), "Export Data",
                      "images/upload.png"),
                  Divider(color: Colors.grey.withOpacity(0.2),),
                  InkWell(
                      onTap: () {
                        AuthService().signOut(context);
                      },
                      child: profileButton(const Color(0xffFDD5D7), "Logout",
                          "images/logout.png")),
                  const SizedBox(
                    height: 14,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      )),
    );
  }
}
