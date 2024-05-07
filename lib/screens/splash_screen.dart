import 'package:cipher_schools_flutter_assignment/helper/SharedPreferencesService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cipher_schools_flutter_assignment/screens/intro_screen.dart';

import 'Home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isSignedIn = false;

  changeScreen() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.to( _isSignedIn ? const HomePage() : const IntroScreen());
    });
  }

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
    changeScreen();
  }

  getUserLoggedInStatus() async {
    await SharedPreferencesService.getUserLoggedInStatus().then((value) {
      if (value != null) {
          _isSignedIn = value;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/splash.png'), fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset('images/logo.png'),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Open Source ",
                      style: TextStyle(color: Colors.grey[400],fontSize: 18),
                    ),
                    const Text(
                      "Community",
                      style: TextStyle(color: Colors.orange,fontSize: 18),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
