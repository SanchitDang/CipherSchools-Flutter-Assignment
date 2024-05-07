import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cipher_schools_flutter_assignment/consts/colors.dart';
import 'package:cipher_schools_flutter_assignment/screens/auth_screens/signup_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/splash.png'), fit: BoxFit.fill)),
          child: Column(
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    'images/logo.png',
                    width: 100,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome To",
                              style:
                              TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            Text(
                              "CypherX",
                              style:
                              TextStyle(fontSize: 34, color: Colors.white),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        CircleAvatar(
                          backgroundColor: const Color(0xffD0C1EA),
                          radius: 45,
                          child: IconButton(
                              onPressed: () {
                                Get.to( SignUpScreen());
                              },
                              icon: const Icon(
                                Icons.chevron_right_rounded,
                                size: 70,
                              )),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "The best way to track your expenses",
                      style: TextStyle(fontSize: 22, color: whiteColor,fontFamily: "bruno"),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
