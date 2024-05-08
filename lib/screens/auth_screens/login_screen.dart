import 'package:cipher_schools_flutter_assignment/helper/loading.dart';
import 'package:cipher_schools_flutter_assignment/common%20widgets/custom_text_field.dart';
import 'package:cipher_schools_flutter_assignment/common%20widgets/login_button.dart';
import 'package:cipher_schools_flutter_assignment/consts/colors.dart';
import 'package:cipher_schools_flutter_assignment/screens/auth_screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cipher_schools_flutter_assignment/service/AuthService.dart';

import '../Home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool terms = true;

  @override
  Widget build(BuildContext context) {

    var media = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.keyboard_backspace,
                      color: Colors.black,
                      size: 28,
                    ),
                  ),
                  const Text(
                    "Log In",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),
            const SizedBox(
              height: 34,
            ),
            const SizedBox(
              height: 50,
            ),
            CustomTextField(
              hint: "Email",
              controller: _emailController,
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextField(
              hint: "Password",
              showVisibilityIcon: true,
              controller: _passwordController,
            ),
            const SizedBox(
              height: 20,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      if (terms == true) {
                        terms = false;
                      } else {
                        terms = true;
                      }
                    });
                  },
                  child: Container(
                      height: media.width * 0.07,
                      width: media.width * 0.07,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: primaryColor, width: 2),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          color: (terms == true)
                              ? primaryColor
                              : Colors.white),
                      child: const Icon(Icons.done, color: Colors.white)),
                ),
                SizedBox(
                  width: media.width * 0.03,
                ),
                SizedBox(
                  width: media.width * 0.75,
                  child: Wrap(
                    children: [
                      const Text(
                        'By Logining in, you agree to the ',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // openBrowser('terms and conditions url');
                        },
                        child: const Text(
                          'Terms of Service and Privacy Policy',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
            const SizedBox(
              height: 30,
            ),

            SizedBox(
              height: 60,
              width: 350,
              child: loginButton(() => login(), "Login"),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Or with",
              style: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            googleButton("Login with Google"),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(color: fontGrey),
                ),
                GestureDetector(
                    onTap: () {
                      Get.to(SignUpScreen());
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: primaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor: primaryColor,
                      ),
                    ))
              ],
            )
          ],
        ),
      )),
    );
  }

  login() async {
    if (true) {
      await AuthService()
          .loginWithUserNameAndPassword(
              _emailController.text, _passwordController.text)
          .then((value) async {
        if (value == true) {
          Get.to(const HomePage());
        }
      });
    }
  }
}
