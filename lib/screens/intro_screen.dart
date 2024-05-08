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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                    EdgeInsets.fromLTRB(25, 60, 0,0),
                    child: Image.asset(
                      'images/logo.png',
                      width: 110,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Welcome to",
                                style:
                                TextStyle(fontSize: 38, color: Colors.white, fontFamily: "ABeeZee-Regular"),
                              ),
                              Text(
                                "CipherX.",
                                style:
                                TextStyle(fontSize: 30, color: Colors.white, fontFamily: "BrunoAceSC-Regular"),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(SignUpScreen());
                            },
                            child: const CircleAvatar(
                              backgroundColor: Color(0xffD0C1EA),
                              radius: 40,
                              child:
                              Icon(
                                    Icons.chevron_right_rounded,
                                    size: 80,
                                  )
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "The best way to track your expenses.",
                      style: TextStyle(fontSize: 18, color: whiteColor, fontFamily: "ABeeZee-Regular"),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                  ],

                ),

              )
            ],
          )),
    );
  }
}
