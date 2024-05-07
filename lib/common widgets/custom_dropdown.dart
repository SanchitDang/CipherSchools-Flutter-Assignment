import 'package:flutter/material.dart';
import 'package:cipher_schools_flutter_assignment/consts/styles.dart';
import 'package:cipher_schools_flutter_assignment/consts/colors.dart';

class CustomDropdown extends StatefulWidget {
  final String hint;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  const CustomDropdown(
      {super.key,
      required this.hint,
      required this.items,
      required this.onChanged});

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DropdownButtonFormField<String>(
        icon: const Icon(Icons.keyboard_arrow_down, size: 30,),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: const TextStyle( fontWeight: FontWeight.w400, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey.shade50, width: 0.4), // Adjust the width here
          ),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
        value: _selectedItem,
        onChanged: (String? newValue) {
          setState(() {
            _selectedItem = newValue;
          });
          widget.onChanged(newValue);
        },
        items: widget.items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
          );
        }).toList(),
      ),
    );
  }

}
