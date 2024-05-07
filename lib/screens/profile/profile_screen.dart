import 'package:cipher_schools_flutter_assignment/common%20widgets/profile_button.dart';
import 'package:cipher_schools_flutter_assignment/consts/colors.dart';
import 'package:cipher_schools_flutter_assignment/consts/styles.dart';
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
            Row(
              children: [
                 CircleAvatar(
                  radius: 45,
                  child: Image.asset('images/profile_image.png',width: 150,fit: BoxFit.cover,),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Username",
                      style: TextStyle(color: fontGrey, fontSize: 16),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Khushi Sharma",
                      style: TextStyle(fontSize: 28, fontFamily: bold),
                    )
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.edit,
                      size: 30,
                    ))
              ],
            ),
            const SizedBox(height: 20,),
            profileButton(const Color(0xffEEE5FF),"Account","images/Wallet.png"),
            const SizedBox(height: 10,),
            profileButton(const Color(0xffEEE5FF),"Settings","images/Wallet.png"),
            const SizedBox(height: 10,),
            profileButton(const Color(0xffEEE5FF),"Export Data","images/upload.png"),
            const SizedBox(height: 10,),
            InkWell(
                onTap: () {
                  AuthService().signOut(context);
                },
                child: profileButton(const Color(0xffFDD5D7),"Logout","images/logout.png")),
            const SizedBox(height: 10,),
            
          ],
        ),
      )),
    );
  }
}
