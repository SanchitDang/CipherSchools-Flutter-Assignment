import 'package:cipher_schools_flutter_assignment/consts/styles.dart';
import 'package:flutter/material.dart';
import 'package:cipher_schools_flutter_assignment/consts/colors.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final bool? showVisibilityIcon;
  final TextEditingController controller;
  CustomTextField(
      {super.key,
      required this.hint,
      this.showVisibilityIcon,
      required this.controller});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscureText,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: const TextStyle(fontFamily: semibold, color: fontGrey),
          filled: true,
          fillColor: whiteColor,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          suffixIcon: widget.showVisibilityIcon ?? false
              ? IconButton(
                  onPressed: () {
                    // Update the state to toggle visibility
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                    // Move the cursor to the end after changing visibility
                    widget.controller.selection = TextSelection.collapsed(
                        offset: widget.controller.text.length);
                  },
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
