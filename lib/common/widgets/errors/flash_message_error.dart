import 'package:flutter/material.dart';

import 'custom_snackbar_content.dart';

class FlashMessageScreen extends StatelessWidget {
  const FlashMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: CustomSnackBarContent(
                  snackBarTitle: 'Oh snap!',
                  snackBarSubtitle: 'This is a flash message',
                  backgroundColor: Colors.red,
                ),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            );
          },
          child: const Text(
            'Flash Message',
          ),
        ),
      ),
    );
  }
}
