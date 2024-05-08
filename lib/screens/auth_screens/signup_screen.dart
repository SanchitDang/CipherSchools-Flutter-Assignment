import 'package:cipher_schools_flutter_assignment/common%20widgets/custom_text_field.dart';
import 'package:cipher_schools_flutter_assignment/common%20widgets/login_button.dart';
import 'package:cipher_schools_flutter_assignment/consts/colors.dart';
import 'package:cipher_schools_flutter_assignment/screens/Home/home_screen.dart';
import 'package:cipher_schools_flutter_assignment/screens/auth_screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cipher_schools_flutter_assignment/service/AuthService.dart';

import '../../helper/loading.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool terms = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                    "Sign Up",
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
              hint: "Name",
              controller: _nameController,
            ),
            const SizedBox(
              height: 15,
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
                              color: const Color(0xff803efa), width: 2),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          color: (terms == true)
                              ? const Color(0xff803efa)
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
                        'By Signing up, you agree to the ',
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
                            color: Color(0xff803efa),
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
              child: loginButton(() {
                register();
              }, "Sign Up"),
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
            googleButton("Sign Up with Google"),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account? ",
                  style: TextStyle(color: fontGrey),
                ),
                GestureDetector(
                    onTap: () {
                      Get.to(LoginScreen());
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Color(0xff803efa),
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xff803efa),
                      ),
                    ))
              ],
            )
          ],
        ),
      )),
    );
  }

  register() async {
    if (true) {
      await AuthService()
          .registerUserWithEmailAndPassword(_nameController.text,
              _emailController.text, _passwordController.text, "imgURL")
          .then((value) async {
        if (value == true) {
          Get.to(const HomePage());
        }
      });
    }
  }
}
