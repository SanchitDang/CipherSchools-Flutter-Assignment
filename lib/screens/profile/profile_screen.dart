import 'package:cipher_schools_flutter_assignment/common%20widgets/profile_button.dart';
import 'package:cipher_schools_flutter_assignment/consts/colors.dart';
import 'package:cipher_schools_flutter_assignment/consts/styles.dart';
import 'package:cipher_schools_flutter_assignment/controller/profile_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:cipher_schools_flutter_assignment/service/AuthService.dart';
import 'package:get/get.dart';

import '../../helper/confirmation_dialog.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProfilePageController profilePageController =
        Get.put(ProfilePageController());
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
                      color: primaryColor, // Purple color border
                      width: 2.5, // Border width
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.transparent,
                      child: Image.asset(
                        'images/profile.png',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Obx(() => Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profilePageController.email.value,
                            style:
                                const TextStyle(color: fontGrey, fontSize: 14),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            profilePageController.name.value,
                            style:
                                const TextStyle(fontSize: 26, fontFamily: bold),
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    )),
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
                  Divider(
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  profileButton(
                      const Color(0xffEEE5FF), "Settings", "images/Wallet.png"),
                  Divider(
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  profileButton(const Color(0xffEEE5FF), "Export Data",
                      "images/upload.png"),
                  Divider(
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  InkWell(
                      onTap: () {
                        Get.dialog(ConfirmationDialog(
                            title: 'Wait a second!',
                            content: 'Are you sure you want to sign out?',
                            onConfirmation: () {
                              AuthService().signOut(context);
                            },
                            onCancellation: () {
                              Get.back();
                            }));
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
