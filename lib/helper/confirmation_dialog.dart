import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final void Function() onConfirmation;
  final void Function() onCancellation;

  const ConfirmationDialog(
      {super.key,
        required this.title,
        required this.content,
        required this.onConfirmation,
        required this.onCancellation});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: Text(
        content,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: onConfirmation,
              child: const Text(
                'Yes',
                style: TextStyle(color: Color(0xffFD3C4A)),
              ),
            ),
            const SizedBox(width: 20),
            InkWell(
              onTap: onCancellation,
              child: const Text(
                'No',
                style: TextStyle(color: Color(0xff00A86B)),
              ),
            ),
          ],
        )
      ],
    );
  }
}
