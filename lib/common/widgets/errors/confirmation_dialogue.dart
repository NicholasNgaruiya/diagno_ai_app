import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String message;

  const ConfirmationDialog({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirmation'),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true); // Return true if user confirms
          },
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false); // Return false if user cancels
          },
          child: const Text('No'),
        ),
      ],
    );
  }
}
