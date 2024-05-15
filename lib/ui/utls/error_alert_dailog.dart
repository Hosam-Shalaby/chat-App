import 'package:flutter/material.dart';

class ErrorAlertDailog extends StatelessWidget {
  const ErrorAlertDailog({super.key, required this.message});

  final String message;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Text(message),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
            child: const Text('OK'))
      ],
    );
  }
}
