import 'package:cipher_schools_flutter_assignment/common%20widgets/custom_text_field.dart';
import 'package:cipher_schools_flutter_assignment/common%20widgets/login_button.dart';
import 'package:cipher_schools_flutter_assignment/consts/colors.dart';
import 'package:cipher_schools_flutter_assignment/screens/Home/home_screen.dart';
import 'package:cipher_schools_flutter_assignment/screens/auth_screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cipher_schools_flutter_assignment/service/AuthService.dart';

import '../../helper/SharedPreferencesService.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 25,
            ),
            CircleAvatar(
              radius: 50,
              backgroundColor: const Color(0xff7f00ff),
              child: Image.asset('images/logo.png'),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Expense Tracker",
              style: TextStyle(fontSize: 20),
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
            const Text(
              "Or with",
              style: TextStyle(color: fontGrey),
            ),
            const SizedBox(
              height: 10,
            ),
            googleButton("Sign Up with "),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(color: fontGrey),
                ),
                TextButton(
                    onPressed: () {
                      Get.to(LoginScren());
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 16),
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
      // setState(() {
      //   _isLoading = true;
      // });
      await AuthService()
          .registerUserWithEmailAndPassword(_nameController.text,
              _emailController.text, _passwordController.text, "imgURL")
          .then((value) async {
        if (value == true) {
          Get.to(const HomePage());
        } else {
          // showSnackbar(context, Colors.red, value);
          // setState(() {
          //   _isLoading = false;
          // });
        }
      });
    }
  }
}
