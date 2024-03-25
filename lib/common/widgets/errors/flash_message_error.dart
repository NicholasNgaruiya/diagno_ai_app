import 'package:flutter/material.dart';
import 'package:restaurant_frontend/common/widgets/errors/custom_snackbar_content.dart';

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
                  errorTitle: 'Oh snap!',
                  errorSubtitle: 'This is a flash message',
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