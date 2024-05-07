import 'package:flutter/material.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Budget"), centerTitle: true, leading: const SizedBox(), elevation: 1,
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [

          ],
        )
      ),
    );
  }
}